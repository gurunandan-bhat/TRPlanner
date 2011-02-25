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
use MIME::Lite;
use Data::FormValidator;
use Data::FormValidator::Constraints qw(:closures);
use Data::FormValidator::Constraints::Upload qw(file_format file_max_bytes);
use Digest::MD5 qw{md5_hex};
use POSIX;
use URI::Escape;

use Data::Dumper;
	

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
	
	if (! $q->param('submit')) {
		
		my $tpl = $app->load_tmpl('upload.tpl', die_on_bad_params => 0);
		return $tpl->output;
	}
	
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

		return $tpl->output;
	}

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
		return $tpl->output;
	} 

	my $pdfcpy = $app->config_param('default.UserDir') . '/' . "$pdfqid$pdfsufx";
	my $txtcpy = $app->config_param('default.UserDir') . '/' . "$txtqid$txtsufx";

	my $pdfok = $q->upload('pdffile', $pdfcpy);
	my $txtok = $q->upload('txtfile', $txtcpy);
	
	if (!($pdfok && $txtok)) {

		my $tpl = $app->load_tmpl('upload.tpl', die_on_bad_params => 0);
		$tpl->param(
			filecp_errors => 'Error Copying Files: ' . $q->cgi_error(),
			pdffile => $q->param('pdffile'),
			txtfile => $q->param('txtfile'),
		);
		return $tpl->output;
	}
	
	my %paycfg;
	Config::Simple->import_from($txtcpy, \%paycfg);

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
		return $tpl->output;
	} 

	my $tpl = $app->load_tmpl('confirm_quote.tpl', die_on_bad_params => 0);
	$tpl->param(
		qid 	=> $paycfg{'Quotation.Id'},
		lead 	=> $paycfg{'Lead.PartyName'},
		email 	=> $email,
		pax 	=> $paycfg{'Lead.NumPax'},
		ratepp 	=> $paycfg{'Quotation.AmountPerPerson'},
		taxpc 	=> $paycfg{'Quotation.ServiceTaxPercentage'},
		tax 	=> $paycfg{'Quotation.ServiceTax'},
		amt 	=> $paycfg{'Quotation.TotalAmt'},
		advamt 	=> $paycfg{'Payment.AdvanceAmt'},
		advdate => odyssey_date($paycfg{'Payment.AdvanceDueOn'}),
		balamt 	=> $paycfg{'Payment.BalanceAmt'},
		baldate => odyssey_date($paycfg{'Payment.BalanceAmtDueOn'}),
		curr 	=> $paycfg{'Quotation.Currency'},
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

	my $emailtpl = $app->load_tmpl('email_final_quote.tpl', die_on_bad_params => 0);
	$emailtpl->param(
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
	);
	
	my $msg = MIME::Lite->new(
		To => 		$email,
		From => 	'Travellers Palm Administrator <webmaster@travellers-palm.com>',
		Subject => 	'Quotation Sent: ' . $qid,
		Type => 	'multipart/related',
		CC => 		'hans@odyssey.co.in',
		BCC => 		'gbhat@pobox.com', 
	);
	
	
	$msg->attach(
		Type => 'text/html',
		Data => $emailtpl->output,
	);

	MIME::Lite->send(
		'smtp', 
		'travellers-palm.com', 
		Timeout => 30,
		AuthUser => 'webmaster+travellers-palm.com',
		AuthPass => 'ip31415',
		Debug => 1,
	);
	eval {
		$msg->send;
	};
	if (@$) {
		die(type => 'error', msg => "Could not send email to recipients: $@. Aborting!")
	}
	
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
	$tpl->param(
		qid => $quote->{id},
		uuid => $uuid,
		digest => $digest,
		lead => $quote->{lead},
		email => $quote->{userid},
		pax => $quote->{pax},
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
		required_regexp => qr/(^name|^nationality|^passport|^issuedat|^issuedon|^expireson)\d+/,
		required => [qw{
				address1
				city
				zip
				state
				country
				email
				travelemail
				telehome
				ecorrname
				eemail
				etelehome
				etelecell
				haveread
				goodhealth
			}
		],
		constraint_methods => {
			email => email(),
			travelemail => email(),
			eemail => email(),
			telehome => phone(),
			etelehome => phone(),
			etelecell => phone(),
		},
		msgs => {
			prefix => 'err_',
			any_errors => 'some_errors',
		},
	};

	my $results = Data::FormValidator->check($q, $dfv);
	my $msgs = $results->msgs;
	my $valids = $results->valid;
	
	my $pax;
	if ($results->has_invalid or $results->has_missing) {
		
		my $qid = $app->session->param('qid');
		my $uuid = $app->session->param('uuid');
		my $digest = $app->session->param('digest');
		
		my $sth = $app->dbh->prepare("select * from quotations where id = ? and uuid = ? and digest = ?") or die("Cannot prepare select");
		$sth->execute($qid, $uuid, $digest) or die("Cannot execute select for quotation: $qid");
		my $quote = $sth->fetchrow_hashref('NAME_lc') or die("Cannot fetch fields for quotation: $qid");
		$pax = $quote->{pax};
		
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

	my $fqid = $q->param('qid');
	my $fuuid = $q->param('uuid');
	my $fdigest = $q->param('digest');

	my $sqid = $app->session->param('qid');
	my $suuid = $app->session->param('uuid');
	my $sdigest = $app->session->param('digest');
	
	die("Strange Error; Tampering Found")
		unless (($sqid == $fqid) && ($suuid eq $fuuid) && ($sdigest eq $fdigest));
	
	my $pug = new Data::UUID;
	my $puuid = $pug->create_str;

	my $psth = $app->dbh->prepare("insert into party
		qid,
		uuid,
		puuid,
		lead,
		addr1,
		addr2,
		city,
		zip,
		state,
		country,
		email,
		travelemail,
		telehome,
		ecorrname,
		eemail,
		etelehome,
		etelecell,
		iagree,
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
	$psth->execute(
		$fqid,
		$fuuid,
		$puuid,
		$valids->{addr1},
		$valids->{addr2},
		$valids->{city},
		$valids->{zip},
		$valids->{'state'},
		$valids->{country},
		$valids->{email},
		$valids->{travelemail},
		$valids->{telehome},
		$valids->{ecorrname},
		$valids->{eemail},
		$valids->{etelehome},
		$valids->{etelecell},
		$valids->{iagree},
		$valids->{haveread},
		$valids->{goodhealth},
		POSIX::strftime('%d %b %Y %H:%M:%S', localtime()),
	) or die("Cannot Insert Party Details");

	my $pph = $app->dbh->prepare("insert into partypeople
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
	
	foreach (0..$pax - 1) {
		$pph->execute(
			$fqid,
			$fuuid,
			$puuid,
			$valids->{'name' . $_},
			$valids->{'nationality' . $_},
			$valids->{'passport' . $_},
			$valids->{'issuedat' . $_},
			$valids->{'issuedon' . $_},
			$valids->{'expireson' . $_},
			POSIX::strftime('%d %b %Y %H:%M:%S', localtime()),
			$_
		) or die("Cannot insert Party people");
	}
	
	my $sth = $app->dbh->prepare('select * from quotations where id = ? and uuid = ?') or die("Cannot prepare select");
	$sth->execute($fqid, $fuuid) or die("Cannot execute select");
	
	my $quote = $sth->fetchrow_hashref('NAME_lc');

	my $advamt = $quote->{advamt};
	my $balamt = $quote->{balamt};
	my $payable = $advamt || $balamt;
	
	my $ottcurrency = OdysseyDB::Currency->retrieve(currencies_id => $quote->{currency});	
	my $merchantid = $ottcurrency->merchantid;
	my $hdfccode = $ottcurrency->hdfccode;
	my $terminalid = $ottcurrency->terminalid;
	
	
	foreach (qw/addr1 addr2 email telehome etelehome ecell eaddr1 eaddr2 /) {
		$valids->{$_} =~ s/\Q<>(){}[]?&*~`!#$%^=+|\:'",;\E/\_/g;
	}
	my $addrstr = $valids->{addr1} . ' ' . $valids->{addr2} . ' ' . $valids->{city} . ' ' . $valids->{zip} . ' ' . $valids->{'state'} . ' ' . $valids->{country};
	
	my $ua = LWP::UserAgent->new;
	my $resp = $ua->request(POST $app->config_param('PassthroughURL'), [
		respurl => $app->config_param('ResponseURL'),
		errurl => $app->config_param('ErrorURL'),
		rsrcpath => $app->config_param('ResourcePath') . "$merchantid/",
		alias => $terminalid,
		currency => sprintf('%03d', $hdfccode),
		amount => $payable,
		trackid => $puuid,
		udf1 => "Tour Payment Against Quotation $fqid",
		udf2 => $valids->{email},
		udf3 => $valids->{telehome},
		udf4 => $addrstr,
		udf5 => $ottcurrency->currencycode,
	]);
	
	if ($resp->is_success) {
		if (my $rdurl = $resp->decoded_content) {
			if ($rdurl =~ /$RE{URI}{HTTP}{-scheme => 'https'}/) {
				$app->redirect($rdurl) ;
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

	my $qid = $params->{trackid};
	my $uuid = $params->{udf1};
	
	my $digest = md5_hex($params->{udf1}, $params->{udf2}, $params->{udf3}, $params->{udf4}, $params->{udf5}, $params->{result});

	my $pug = new Data::UUID;
	my $puuid = $pug->create_str;

	$sth->execute(
		$qid,
		$puuid,
		'Custom Tour',
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

	return 'REDIRECT=' . $app->config_param('default.RedirectURL') . "$qid/$puuid/$digest";
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

	my $qsth = $app->dbh->prepare("select lead from quotations where id = ? and uuid = ?")
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
		From => 	'Travellers Palm Administrator <webmaster@travellers-palm.com>',
		Subject => 	'Your Payment to Travellers Palm for Quotation: ' . $qid,
		Type => 	'multipart/related',
		CC => 		'hans@odyssey.co.in',
		BCC => 		'gbhat@pobox.com', 
	);
	
	$msg->attach(
		Type => 'text/html',
		Data => $emailtpl->output,
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
		AuthUser => 'webmaster+travellers-palm.com',
		AuthPass => 'ip31415',
		Debug => 1,
	);
	eval {
		$msg->send;
	};
	if (@$) {
		die(type => 'error', msg => "Could not send email to recipients: $@. Aborting!")
	}

	my $ftpl = ($plog->{result} eq 'CAPTURED') ? 'payment_thanks.tpl' : 'payment_regret.tpl';
	my $tpl = $app->load_tmpl($ftpl, die_on_bad_params => 0);
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
	return $tpl->output;
}

sub failure {

	my $app = shift;
	my $q = $app->query;

	my @params = $q->param();
	return '<pre>' . Dumper(\@params) . '</pre>';	
}

sub odyssey_date {

	my $dtstr = shift;
	my ($y, $m, $d) = split(/\-/, $dtstr);
	
	return '' if ($y eq '0000');

	$m =~ s/^0+//;
	return ("$d " . $months->[$m] . " $y");
}


1;
