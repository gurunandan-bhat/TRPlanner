package Odyssey::Payment;

use strict;
use warnings;

use LWP::UserAgent;
use HTTP::Request::Common;
use Regexp::Common qw{URI};
use Data::UUID;
use File::Basename qw(fileparse fileparse_set_fstype);
use File::Copy;
use HTTP::BrowserDetect;
use Config::Simple;
use Email::Valid;
use MIME::Entity;
use Email::Sender::Simple qw{sendmail};
use Email::Sender::Transport::SMTP::TLS;
use MIME::Lite;
use Data::FormValidator;
use Data::FormValidator::Constraints qw(:closures);
use Data::FormValidator::Constraints::Upload qw(file_format file_max_bytes);
use Digest::MD5 qw{md5_hex};
use POSIX;
use URI::Escape;
use Digest::SHA qw{sha256_hex};

use Data::Dumper;
use Try::Tiny;

use lib qw{../};
use OdysseyDB::Currency;

use base qw(Odyssey);

my $months = [
	qw(Inv Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
];

sub setup {
	my $app = shift;
	
	$app->mode_param('mode');

	$app->run_modes(
		index => 'index',
		upload_quote => 'upload_quote',
		save_quote => 'save_quote',
        send_quote => 'send_quote',
		show_quote => 'show_quote',
		success => 'success',
		failure => 'failure',
		togateway => 'togateway',
		thanks => 'thanks',
	);

	$app->start_mode('success');
	$app->error_mode('errhndlr');
}

sub index {
	
	my $app = shift;
	my $tpl = $app->load_tmpl('checkout.tpl');
		
	return $tpl->output;
}

sub upload_quote {
	
	my $app = shift;
	my $q = $app->query;
	
	print STDERR "Got a GET request\n";
	my $tpl = $app->load_tmpl('upload.tpl', die_on_bad_params => 0);
	return $tpl->output;
}

sub send_quote {
    
    my $app = shift;
    my $q = $app->query;
    
    print STDERR "Got a POST request\n";
    my $dfv = {
        required => [ qw{pdffile txtfile} ],
        constraint_methods => {
            pdffile => [
                file_format(mime_types => ['application/pdf']),
                file_max_bytes(5*1024*1024),
            ],
            txtfile => [
                file_format(mime_types => ['text/plain']),
                file_max_bytes(100*1024),
            ],
        },
        filters => 'trim',
        msgs => {
            prefix => 'err_',
            any_errors => 'some_errors',
            constraints => {
                file_format => 'File does not have expected type',
                file_max_bytes => 'File Size Exceeds Size Limit',
            },
        },
    };

    my $check = Data::FormValidator->check($q, $dfv);
    my $valids = $check->valid;

    if ($check->has_invalid or $check->has_missing) {

        my $tpl = $app->load_tmpl('upload.tpl', die_on_bad_params => 0);
        $tpl->param($check->msgs);
        $tpl->param($valids);

        print STDERR "Messages: " . Dumper($check->msgs) . "\n";
        print STDERR "Got an invalid form\n";
        return $tpl->output;
    }

    print STDERR "Valids: " . Dumper($valids);
    
    my $browser = HTTP::BrowserDetect->new();
    my $osstr = $browser->windows ? 'MSWin32' : (
        $browser->unix ? 'Unix' : (
            $browser->mac ? 'MacOS' : 'Unknown'
        )
    );
    fileparse_set_fstype($osstr);

    my ($pdfqid, $pdfdir, $pdfsufx) = fileparse($q->param('pdffile'), qr/\.[^.]*/);
    my ($txtqid, $txtdir, $txtsufx) = fileparse($q->param('txtfile'), qr/\.[^.]*/);

    if (!(($pdfqid =~ /^\d+$/) && ($pdfqid == $txtqid))) {

        my $tpl = $app->load_tmpl('upload.tpl', die_on_bad_params => 0);
        $tpl->param(
            mismatch_errors => 1,
            pdffile => $q->param('pdffile'),
            txtfile => $q->param('txtfile'),
        );
        print STDERR "Invalid Extensions\n";
        return $tpl->output;
    } 

    my $buffer;
    
    my $pdfcpy = $app->config_param('default.UserDir') . '/' . "$pdfqid$pdfsufx";
    my $pdfok = $q->upload('pdffile')->handle;
    open FH, ">$pdfcpy" or die "Cannot open file at path $pdfcpy $!\n";
    binmode FH;
    print FH $buffer while read( $pdfok, $buffer, 4096);
    close FH;
    
    $buffer = undef;
    my $txtcpy = $app->config_param('default.UserDir') . '/' . "$txtqid$txtsufx";
    my $txtok = $q->upload('txtfile')->handle;
    open FH, ">$txtcpy" or die "Cannot open file at path $txtcpy $!\n";
    binmode FH;
    print FH $buffer while read( $txtok, $buffer, 4096 );
    close FH;
    
    my %paycfg;
    Config::Simple->import_from($txtcpy, \%paycfg);

    print STDERR "Uploaded Config: " . Dumper(\%paycfg) . "\n";
    
    if (! %paycfg) {
        
        my $tpl = $app->load_tmpl('upload.tpl', die_on_bad_params => 0);
        $tpl->param(
            invalid_config => 1,
            pdffile => $q->param('pdffile'),
            txtfile => $q->param('txtfile'),
        );
        return $tpl->output;
    }

    my $email;
    if (! ($email = Email::Valid->address($paycfg{'Lead.Email'}))) {
        
        my $tpl = $app->load_tmpl('upload.tpl', die_on_bad_params => 0);
        $tpl->param(
            invalid_email => 1,
            pdffile => $q->param('pdffile'),
            txtfile => $q->param('txtfile'),
        );
        print STDERR "Invalid Email: $email\n";
        return $tpl->output;
    } 

    my $tpl = $app->load_tmpl('confirm_quote.tpl', die_on_bad_params => 0);
    $tpl->param(
        qid     => $paycfg{'Quotation.Id'},
        lead    => $paycfg{'Lead.PartyName'},
        email   => $email,
        pax     => $paycfg{'Lead.NumPax'},
        ratepp  => $paycfg{'Quotation.AmountPerPerson'},
        taxpc   => $paycfg{'Quotation.ServiceTaxPercentage'},
        tax     => $paycfg{'Quotation.ServiceTax'},
        amt     => $paycfg{'Quotation.TotalAmt'},
        advamt  => $paycfg{'Payment.AdvanceAmt'},
        advdate => odyssey_date($paycfg{'Payment.AdvanceDueOn'}),
        balamt  => $paycfg{'Payment.BalanceAmt'},
        baldate => odyssey_date($paycfg{'Payment.BalanceAmtDueOn'}),
        curr    => $paycfg{'Quotation.Currency'},
        currency => OdysseyDB::Currency->retrieve(currencies_id => $paycfg{'Quotation.Currency'})->currencycode,
    );

    return $tpl->output;
}

sub save_quote {
	
	my $app = shift;
	my $q = $app->query;
	
	my $qid = $q->param('qid');
	my $lead = $q->param('lead');
	my $email = $q->param('email');
	my $pax = $q->param('pax');
	my $ratepp = $q->param('ratepp');
	my $taxpc = $q->param('taxpc');
	my $tax = $q->param('tax');
	my $amt = $q->param('amt');
	my $advamt = $q->param('advamt');
	my $advdate = $q->param('advdate');
	my $balamt = $q->param('balamt');
	my $baldate = $q->param('baldate');
	my $curr = $q->param('curr');
	my $currency = $q->param('currency');

	my $ug = new Data::UUID;
	my $uuid = $ug->create_str;
	
	my $digest = md5_hex($qid, $lead, $email, $uuid);
	my $sth = $app->dbh->prepare("
		insert into quotations (
			id,
			userid,
			lead,
			pax,
			currency,
			amtpp,
			taxpc,
			tax,
			total,
			advamt,
			advdate,
			balamt,
			baldate,
			digest,
			addedon,
			uuid
		)
		values (
			?,
			?,
			?,
			?,
			?,
			?,
			?,
			?,
			?,
			?,
			?,
			?,
			?,
			?,
			?,
			?
		)"
	) or die("Cannot prepare insert!" . $app->dbh->errstr);
	$sth->execute($qid, $email, $lead, $pax, $curr, $ratepp, $taxpc, $tax, $amt, $advamt, $advdate, $balamt, $baldate, $digest, POSIX::strftime('%d %b %Y %H:%M:%S', localtime()), $uuid) 
		or die("Cannot execute insert: " . $app->dbh->errstr);

	my $emailtpl = $app->load_tmpl('email_new_quote.tpl', die_on_bad_params => 0);
	my $tmpl_vars = {
		qid => $qid,
		lead => $lead,
		email => $email,
		pax => $pax,
		ratepp => $ratepp,
		currency => $currency,
		touramt => $ratepp * $pax,
		taxpc => $taxpc,
		tax => $tax,
		amt => $amt,
		is_advance => $advamt ? 1 : undef,
		advamt => $advamt,
		advdate => $advdate,
		balamt => $balamt,
		baldate => $baldate,
		payurl => $app->config_param('default.PayURL') . "$qid/$uuid/$digest",
		subject => 'Quotation for your Tour (No: ' . $qid . ')',
	};
	$emailtpl->param(%{ $tmpl_vars });

	print STDERR Dumper($tmpl_vars);
	
	my $msg = MIME::Entity->build(
	    Type => 'multipart/related',
	    To => $email,
	    From => 'Odyssey Tours and Travels <payments@travellers-palm.com>',
	    Subject => 'Quotation ' . $qid . 'for your Tour',
	    CC => 'gbhat@pobox.com',
	);
	
	# Generate email body and attach
	$msg->attach(
		Type => 'text/html',
		Data => $emailtpl->output,
	);
	# Attach header image
	$msg->attach(
		Type => 'image/png',
		Id => 'tpcom_header',
		Path => $app->config_param('ImagePath') . 'tpcom_header.png',
		Disposition => 'inline',
		Encoding => 'base64',
	);
	
	# Create TLS transport agent for GMail
	my $transport = Email::Sender::Transport::SMTP::TLS->new(
    	host => 'smtp.googlemail.com',
    	port => 587,
    	username => 'payments@travellers-palm.com',
    	password => 'ip31415O',
    	timeout => 300,
	);

	try {
    	sendmail($msg, { transport => $transport });
	} 
	catch {
    	die "Error sending email: $_";
	};
	
	my $tpl = $app->load_tmpl('quote_saved.tpl', die_on_bad_params => 0);
	return $tpl->output;
}

sub show_quote {
	
	my $app = shift;
	my $qid = $app->param('qid');
	my $uuid = $app->param('uuid');
	my $digest = $app->param('digest');
	
	my $sth = $app->dbh->prepare("select * from quotations where id = ? and uuid = ? and digest = ?") or die("Cannot prepare select");
	$sth->execute($qid, $uuid, $digest) or die("Cannot execute select for quotation: $qid");
	
	my $quote = $sth->fetchrow_hashref('NAME_lc') or die("Cannot fetch fields for quotation: $qid");
	
	my $dbdigest = md5_hex($qid, $quote->{lead}, $quote->{userid}, $uuid);

	if ($digest ne $dbdigest) {
		
		my $tpl = $app->load_tmpl('bad_quotation_request.tpl', die_on_bad_params => 0);
		return $tpl->output;
	}

	$app->session->param(
		qid => $qid,
		uuid => $uuid,
		digest => $digest,
	);
	
	my $tpl = $app->load_tmpl('form.tpl', die_on_bad_params => 0);

	my @restpax;
	if ($quote->{pax} > 1) {
		foreach (1 .. $quote->{pax} - 1) {
			push @restpax, {
				paxidx => $_,
				paxorder => $_ + 1,
			};
		}
	}
	$tpl->param(
		qid => $quote->{id},
		uuid => $uuid,
		digest => $digest,
		lead => $quote->{lead},
		email => $quote->{userid},
		pax => $quote->{pax},
		restpax => \@restpax,
		ratepp => $quote->{amtpp},
		currency => OdysseyDB::Currency->retrieve(currencies_id => $quote->{currency})->currencycode,
		touramt => $quote->{amtpp} * $quote->{pax},
		taxpc => $quote->{taxpc},
		tax => $quote->{tax},
		amt => $quote->{total},
		is_advance => $quote->{advamt} ? 1 : undef,
		advamt => $quote->{advamt},
		advdate => $quote->{advdate},
		balamt => $quote->{balamt},
		baldate => $quote->{baldate},
	);

	return $tpl->output;
}

sub togateway {
	
	my $app = shift;
	my $q = $app->query;

	my $dfv = {
		filters => ['trim'],
		required => [qw{
				name1
				corraddress1
				corrcity
				corrzip
				corrcountry
				corremail
				haveread
				goodhealth
			}
		],
		constraint_methods => {
			corremail => email(),
		},
		msgs => {
			prefix => 'err_',
			any_errors => 'some_errors',
		},
	};

	my $results = Data::FormValidator->check($q, $dfv);
	my $msgs = $results->msgs;
	my $valids = $results->valid;
	
#	use Data::Dumper;
#	return '<pre>' . Dumper($valids) . 'Missing: ' . Dumper($results->missing) . 'Invalid: ' . Dumper($results->invalid) . '</pre>';
	
	my $qid = $app->session->param('qid');
	my $uuid = $app->session->param('uuid');
	my $digest = $app->session->param('digest');
	my $sth = $app->dbh->prepare("select * from quotations where id = ? and uuid = ? and digest = ?") or die("Cannot prepare select");
	$sth->execute($qid, $uuid, $digest) or die("Cannot execute select for quotation: $qid");
	my $quote = $sth->fetchrow_hashref('NAME_lc') or die("Cannot fetch fields for quotation: $qid");
	my $pax = $quote->{pax};

	if ($results->has_invalid or $results->has_missing) {
		
		my $tpl = $app->load_tmpl('form.tpl', die_on_bad_params => 0);
		$tpl->param(
			qid => $quote->{id},
			uuid => $uuid,
			digest => $digest,
			lead => $quote->{lead},
			email => $quote->{userid},
			pax => $pax,
			ratepp => $quote->{amtpp},
			currency => OdysseyDB::Currency->retrieve(currencies_id => $quote->{currency})->currencycode,
			touramt => $quote->{amtpp} * $quote->{pax},
			taxpc => $quote->{taxpc},
			tax => $quote->{tax},
			amt => $quote->{total},
			is_advance => $quote->{advamt} ? 1 : undef,
			advamt => $quote->{advamt},
			advdate => $quote->{advdate},
			balamt => $quote->{balamt},
			baldate => $quote->{baldate},
		);
		$tpl->param($msgs);
		$tpl->param($valids);

		return $tpl->output;
	}

# We have everything we need in $valids now
# fxxx are fields from the form

	my $fqid = $q->param('qid');
	my $fuuid = $q->param('uuid');
	my $fdigest = $q->param('digest');

	die("Strange Error; Tampering Found")
		unless (($qid == $fqid) && ($uuid eq $fuuid) && ($digest eq $fdigest));

# Generate a new Payment ID (same quotation may have more than one Payment attempt)	
	my $pug = new Data::UUID;
	my $puuid = substr($pug->create_hex, 2);
	

	my $psth = $app->dbh->prepare("insert into party (
		qid,
		uuid,
		puuid,
		lead,
		addr1,
		addr2,
		city,
		zip,
		country,
		email,
		haveread,
		goodhealth,
		tstamp
	)
	values (
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?
	)") or die("Cannot prepare Party Insert");
#Insert Payment Detail Form variables into party database	
	$psth->execute(
		$fqid,
		$fuuid,
		$puuid,
		$valids->{name1},
		$valids->{corraddress1},
		$valids->{corraddress2},
		$valids->{corrcity},
		$valids->{corrzip},
		$valids->{corrcountry},
		$valids->{corremail},
		$valids->{haveread},
		$valids->{goodhealth},
		POSIX::strftime('%d %b %Y %H:%M:%S', localtime()),
	) or die("Cannot Insert Party Details");

	my $pph = $app->dbh->prepare("insert into partypeople (
		qid,
		uuid,
		puuid,
		name,
		nationality,
		passport,
		issuedat,
		issuedon,
		expireson,
		tstamp,
		peopleid
	)
	values (
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?
	)") or die("Cannot prepare Party people");


# Insert Party people into linked child table	
	# foreach (0..$pax - 1) {
	# 	$pph->execute(
	# 		$fqid,
	# 		$fuuid,
	# 		$valids->{'name' . $_},
	# 		$valids->{'nationality' . $_},
	# 		$valids->{'passport' . $_},
	# 		$valids->{'issuedat' . $_},
	# 		$valids->{'issuedon' . $_},
	# 		$valids->{'expireson' . $_},
	# 		POSIX::strftime('%d %b %Y %H:%M:%S', localtime()),
	# 		$_
	# 	) or die("Cannot insert Party people");
	# }
	
	$sth = $app->dbh->prepare('select * from quotations where id = ? and uuid = ?') or die("Cannot prepare select");
	$sth->execute($fqid, $fuuid) or die("Cannot execute select");
	
	$quote = $sth->fetchrow_hashref('NAME_lc');

# Get the first non-zero amount - that is the payable amount
	my $advamt = $quote->{advamt};
	my $balamt = $quote->{balamt};
	my $payable = $advamt || $balamt;

# Get the HDFC connection parameters 	
# Original Parameters	
#	my $ottcurrency = OdysseyDB::Currency->retrieve(currencies_id => $quote->{currency});	
#	my $merchantid = $ottcurrency->merchantid;
#	my $hdfccode = $ottcurrency->hdfccode;
#	my $terminalid = $ottcurrency->terminalid;
	
	my $id = '90003832';
	my $action = '1';
	my $amt = '6.00';
	my $currency = '356';
	my $trackid = $puuid;
	my $langid = 'USA';
	 
	my $hash_src = "$id$trackid$amt$currency$action";
	my $hash_str = lc(sha256_hex($hash_src));
	print STDERR "$hash_src\n$hash_str\n";
	 	
# Replace suspicious charatcters by an underscore	
	foreach (qw/corraddress1 corraddress2 corrzip corrcity corrcountry/) {
		$valids->{$_} =~ s/[^a-zA-Z0-9]+/\_/g;
	}
	my $addrstr = $valids->{corraddress1} . ' ' . 
		$valids->{corraddress2} . ' ' . 
		$valids->{corrcity} . ' ' . 
		$valids->{corrzip} . ' ' . 
		$valids->{corrcountry};
	
	my $ua = LWP::UserAgent->new(ssl_opts => {verify_hostname => 1});
	my $form = {
        id => $id,
        password => 'password1',
        action => 1,
        amt => $amt,
        currencycode => $currency,
        trackid => $trackid,
        langid => 'USA',
        responseURL => $app->config_param('ResponseURL'),
        errorURL => $app->config_param('ErrorURL'),
        udf1 => $valids->{corremail},
        udf2 => $valids->{corraddress1},
        udf3 => $valids->{corraddress2} || '',
        udf4 => $valids->{corrcity},
        udf5 => $hash_str,
    };
    print STDERR Dumper($form);
    
	my $resp = $ua->post('https://securepgtest.fssnet.co.in/pgway/servlet/PaymentInitHTTPServlet', $form);

# Redirect to Payment Gateway if successful	
	if ($resp->is_success) {
	    print STDERR "Succeeded\n";
		if (my $rdurldata = $resp->decoded_content) {
		    print STDERR "Response is $rdurldata\n";
		    my ($payment_id, $redirect_url) = split(/\:/, $rdurldata, 2);
			if ($redirect_url =~ /$RE{URI}{HTTP}{-scheme => 'https'}/) {
			    
			    $redirect_url .= '?PaymentID=' . $payment_id; 
				$app->redirect($redirect_url) ;
			}
			else {
				die({type => 'error', msg => 'Got an Invalid URL from Gateway. Aborting'});
			}
		}
		else {
			die({type => 'error', msg => 'Got NULL response from URL Converter. Aborting'});
		}
	}
	else {
		die({type => 'error', msg => 'Error Requesting URL: ' . $resp->status_line});
	}
}

sub success {
	
	my $app = shift;
	my $q = $app->query;
	
	my $params = $q->Vars;

# Only puuid is returned from the gateway, so use it to find the quotation upload details
	my $puuid = $params->{trackid};
	my $psth = $app->dbh->prepare("select qid, uuid from party where puuid = ?");
	$psth->execute($puuid);
	my ($qid, $uuid) = $psth->fetchrow_array();
	
	
	my $sth = $app->dbh->prepare('insert into paymentlog (
		qid,
		puuid,
		lead,
		userid,
		tranid,
		avr,
		auth,
		postdate,
		amt,
		ref,
		paymentid,
		result,
		contact,
		address,
		currency,
		digest,
		dtime,
		uuid
	)
	values (
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?,
		?
	)') or die("Cannot prepare insert");

	my $digest = md5_hex($params->{udf1}, $params->{udf2}, $params->{udf3}, $params->{udf4}, $params->{udf5}, $params->{result});

	$sth->execute(
		$qid,
		$puuid,
		$params->{udf1},
		$params->{udf2},
		$params->{tranid},
		$params->{avr},
		$params->{auth},
		$params->{postdate},
		sprintf('%.2f', $params->{amt}),
		$params->{ref},
		$params->{paymentid},
		$params->{result},
		$params->{udf3},
		$params->{udf4},
		$params->{udf5},
		$digest,
		POSIX::strftime('%Y-%m-%d %H:%M:%S', localtime()),
		$uuid
	) or die("Cannot insert into database");

	my $status = $params->{result};
	$status =~ s/^\s+//;
	$status =~ s/\s+$//;
	
	if ($status eq 'CAPTURED') {
		return 'REDIRECT=' . $app->config_param('default.RedirectURL') . "$qid/$puuid/$digest";
	}
	elsif ($status eq 'NOT CAPTURED') {
		return 'REDIRECT=' . $app->config_param('default.FailureURL');
	}
	else {
		return 'REDIRECT=' . $app->config_param('default.FailureURL');
	}
}

sub thanks {
	
	my $app = shift;

	my $qid = $app->param('qid');
	my $puuid = $app->param('puuid');
	my $digest = $app->param('digest');

	my $sth = $app->dbh->prepare("select * from paymentlog where qid = ? and puuid = ? and digest = ?")
		or die("Cannot prepare select");
		
	$sth->execute($qid, $puuid, $digest)
		or die("Cannot execute select");
	my $plog = $sth->fetchrow_hashref('NAME_lc');

	my $uuid = $plog->{uuid};

	my $sqid = $app->session->param('qid');
	my $suuid = $app->session->param('uuid');
	
	die("Not continuing session") 
		unless (($qid == $sqid) && ($uuid eq $suuid));

	my $qsth = $app->dbh->prepare("select * from quotations where id = ? and uuid = ?")
		or die("Cannot prepare quotations select");
	$qsth->execute($qid, $uuid);
	my $qrow = $qsth->fetchrow_hashref('NAME_lc');

	
#TODO digest not checked. To be checked here
	my $emailtpl = $app->load_tmpl('email_payment_thanks.tpl', die_on_bad_params => 0);
	$emailtpl->param(
		qid => $qid,
		lead => $qrow->{lead},
		email => $plog->{userid},
		currency => $plog->{currency},
		ref => $plog->{ref},
		tranid => $plog->{tranid},
		paymentid => $plog->{paymentid},
		trandate => POSIX::strftime('%d %b %Y', localtime()),
		amt => $plog->{amt},
	);
	
	my $msg = MIME::Lite->new(
		To => 		$plog->{userid},
		From => 	'Travellers Palm Administrator <noreply@travellers-palm.com>',
		Subject => 	'Your Payment to Travellers Palm for Quotation: ' . $qid,
		Type => 	'multipart/related',
		CC => 		'hans@odyssey.co.in',
		BCC => 		'accounts@odyssey.co.in, ivan@odyssey.co.in', 
	);
	
	$msg->attach(
		Type => 'text/html',
		Data => $emailtpl->output,
	);
	$msg->attach(
		Type => 'image/jpg',
		Id => 'reciept_banner',
		Path => $app->config_param('default.ImagePath') . 'tp_email_logo.jpg'
	);
	$msg->attach(
		Type => 'application/pdf',
		Path => $app->config_param('default.UserDir') . "/$qid.pdf",
		Filename => 'Tour_Itinerary.pdf'
	);

	MIME::Lite->send(
		'smtp', 
		'travellers-palm.com', 
		Timeout => 30,
		AuthUser => 'webmaster@travellers-palm.com',
		AuthPass => 'ip31415',
		Debug => 1,
	);
	eval {
		$msg->send;
	};
	if (@$) {
		die(type => 'error', msg => "Could not send email to recipients: $@. Aborting!")
	}

	my $tpl = $app->load_tmpl('payment_thanks.tpl', die_on_bad_params => 0);
	$tpl->param(
		qid => $qid,
		lead => $qrow->{lead},
		email => $plog->{userid},
		currency => $plog->{currency},
		ref => $plog->{ref},
		tranid => $plog->{tranid},
		paymentid => $plog->{paymentid},
		trandate => POSIX::strftime('%d %b %Y', localtime()),
		amt => $plog->{amt},
	);

	my $inisth = $app->dbh->prepare("select * from party where uuid = ? and puuid = ?")
		or die("Cannot Prepare Party Details");
	$inisth->execute($uuid, $puuid);
	my $inirow = $inisth->fetchrow_hashref('NAME_lc');
	
	my $ppsth = $app->dbh->prepare("select * from partypeople where uuid = ? and puuid = ? order by peopleid");
	$ppsth->execute($uuid, $puuid);
	my $pprow = $ppsth->fetchrow_hashref('NAME_lc');
			
	my $inidata = {
		qid => $qid,
		uuid => $uuid,
		puuid => $puuid,
		name0 => $inirow->{name0},
		amt => $plog->{amt},
		occ => $qrow->{currency},
		hdfccc => OdysseyDB::Currency->retrieve(currencies_id => $qrow->{currency})->hdfccode,
		isadvance => 1,
		pdate => POSIX::strftime('%Y-%m-%d', localtime()),
		hdfcpid => $plog->{paymentid},
		hdfctid => $plog->{tranid},
		hdfcrid => $plog->{ref},
		name0 => $pprow->{name},
		nationality0 => $pprow->{nationality},
		passport0 => $pprow->{passport},
		issuedat0 => $pprow->{issuedat},
		issuedon0 => $pprow->{issuedon},
		expireson0 => $pprow->{expireson},
		addr1 => $inirow->{addr1},
		addr2 => $inirow->{addr2},
		city => $inirow->{city},
		'state' => $inirow->{'state'},
		zip => $inirow->{zip},
		country => $inirow->{country},
		email => $inirow->{email},
		travelemail => $inirow->{travelemail},
		telehome => $inirow->{telehome},
		ecorrname => $inirow->{ecorrname},
		eemail => $inirow->{eemail},
		etelehome => $inirow->{etelehome},
		etelecell => $inirow->{etelecell},
	};
	
	my @more;
	my $idx = 2;
	while($pprow = $ppsth->fetchrow_hashref('NAME_lc')) {
		push @more, {
			paxidx => 'Pax' . $idx,
			name => $pprow->{name},
			nationality => $pprow->{nationality},
			passport => $pprow->{passport},
			issuedat => $pprow->{issuedat},
			issuedon => $pprow->{issuedon},
			expireson => $pprow->{expireson},
		};
		++$idx;
	}
	$inidata->{paxes} = \@more;
	my $initpl = $app->load_tmpl('odyssey_payment_notify.tpl', die_on_bad_params => 0);
	$initpl->param($inidata);
	
	my $inistr = $initpl->output;
	open(my $tmpini, '>', '/tmp/quote.ini') or die $!;
	print $tmpini $inistr;
	close $tmpini;
	
	$msg = MIME::Lite->new(
		To => 		'accounts@odyssey.co.in, ivan@odyssey.co.in',
		From => 	'Travellers Palm Administrator <noreply@travellers-palm.com>',
		Subject => 	'Payment to Travellers Palm for Quotation: ' . $qid,
		Type => 	'multipart/related',
		CC =>		'hans@odyssey.co.in',
		#BCC => 	'bhat.gurunandan@gmail.com', 
	);
	
	$msg->attach(
		Type => 'text/html',
		Data => '<p>The ini file is attached</p>',
	);
	$msg->attach(
		Type => 'text/plain',
		Path => '/tmp/quote.ini',
		Filename => $qid . '.ini',
		Disposition => 'attachment',
	);

	MIME::Lite->send(
		'smtp', 
		'travellers-palm.com', 
		Timeout => 30,
		AuthUser => 'webmaster@travellers-palm.com',
		AuthPass => 'ip31415',
		Debug => 1,
	);
	eval {
		$msg->send;
	};
	if (@$) {
		die(type => 'error', msg => "Could not send ini email to recipients: $@. Aborting!")
	}
	
	return $tpl->output;
}

sub failure {

	my $app = shift;
	my $tpl = $app->load_tmpl('payment_regret.tpl', die_on_bad_params => 0);
	return $tpl->output;
}

sub odyssey_date {

	my $dtstr = shift;
	my ($y, $m, $d) = split(/\-/, $dtstr);
	
	return '' if ($y eq '0000');

	$m =~ s/^0+//;
	return ("$d " . $months->[$m] . " $y");
}


1;
