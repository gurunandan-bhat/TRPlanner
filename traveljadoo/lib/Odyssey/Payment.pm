package Odyssey::Payment;

use strict;
use warnings;

use LWP::UserAgent;
use HTTP::Request::Common;
use Data::Dumper;
use Regexp::Common qw{URI};
use Data::UUID;
use File::Basename qw(fileparse fileparse_set_fstype);
use File::Copy;
use HTTP::BrowserDetect;
use Config::Simple;
use MIME::Lite;
use Data::FormValidator;
use Data::FormValidator::Constraints::Upload qw(file_format file_max_bytes);

use lib qw{../};
use OdysseyDB::Currency;

use base qw(Odyssey);

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

	my $tpl = $app->load_tmpl('confirm_quote.tpl', die_on_bad_params => 0);

	$tpl->param(
		qid 	=> $paycfg{'Quotation.Id'},
		lead 	=> $paycfg{'Lead.PartyName'},
		email 	=> $paycfg{'Lead.Email'},
		pax 	=> $paycfg{'Lead.NumPax'},
		ratepp 	=> $paycfg{'Quotation.AmountPerPerson'},
		taxpc 	=> $paycfg{'Quotation.ServiceTaxPercentage'},
		tax 	=> $paycfg{'Quotation.ServiceTax'},
		amt 	=> $paycfg{'Quotation.TotalAmt'},
		advamt 	=> $paycfg{'Payment.AdvanceAmt'},
		advdate => $paycfg{'Payment.AdvanceDueOn'},
		balamt 	=> $paycfg{'Payment.BalanceAmt'},
		baldate => $paycfg{'Payment.BalanceAmtDueOn'},
		curr => $paycfg{'Quotation.Currency'},
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
	
	my $sth = $app->dbh->prepare("delete from quotations where id = ?")
		or die({type => 'error', msg => 'Cannot prepare delete of existing quotation'});
	$sth->execute($qid) 
		or die({type => 'error', msg => 'Cannot execute delete of existing quotation'});
	
	$sth = $app->dbh->prepare("
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
			baldate
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
		)"
	) or die("Cannot prepare insert!" . $app->dbh->errstr);
	$sth->execute($qid, $email, $lead, $pax, $curr, $ratepp, $taxpc, $tax, $amt, $advamt, $advdate, $balamt, $baldate) 
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
		has_advance => $advamt ? 1 : undef,
		advamt => $advamt,
		balamt => $balamt,
		payurl => 'http://www.travellers-palm.com/show_quote/' . $qid,
	);
	
	my $msg = MIME::Lite->new(
		To => 		'hans@odyssey.co.in',
		From => 	'Travellers Palm Administrator <webmaster@travellers-palm.com>',
		Subject => 	'Quotation Sent: ' . $qid,
		Type => 	'multipart/related',
		CC => 		'admin@odyssey.co.in, gbhat@pobox.com', 
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
	
	$msg->send;
	
	my $tpl = $app->load_tmpl('quote_saved.tpl', die_on_bad_params => 0);
	return $tpl->output;
}

sub show_quote {
	
	my $app = shift;
	my $qid = $app->param('qid');
	
	$app->session->param(qid => $qid);
	
	my $sth = $app->dbh->prepare("select * from quotations where id = ?") or die("Cannot prepare select");
	$sth->execute($qid) or die("Cannot execute select for quotation: $qid");
	
	my $quote = $sth->fetchrow_hashref('NAME_lc') or die("Cannot fetch fields for quotation: $qid");
	
	my $tpl = $app->load_tmpl('form.tpl', die_on_bad_params => 0);
	$tpl->param(
		qid => $quote->{id},
		lead => $quote->{lead},
		email => $quote->{userid},
		pax => $quote->{pax},
		ratepp => $quote->{amtpp},
		currency => OdysseyDB::Currency->retrieve(currencies_id => $quote->{currency})->currencycode,
		touramt => $quote->{amtpp} * $quote->{pax},
		taxpc => $quote->{taxpc},
		tax => $quote->{tax},
		amt => $quote->{total},
		has_advance => $quote->{advamt} ? 1 : undef,
		advamt => $quote->{advamt},
		balamt => $quote->{balamt},
	);

	return $tpl->output;
}

sub togateway {
	
	my $app = shift;
	my $q = $app->query;
	
	my $fqid = $q->param('qid');
	my $qid = $app->session->param('qid');
	
	die("Strange Error!") unless ($qid == $fqid);
	
	my $sth = $app->dbh->prepare('select * from quotations where id = ?') or die("Cannot prepare select");
	$sth->execute($qid) or die("Cannot execute select");
	
	my $quote = $sth->fetchrow_hashref('NAME_lc');

	my $advamt = $quote->{advamt};
	my $balamt = $quote->{balamt};
	my $payable = $advamt || $balamt;
	
	my $ottcurrency = OdysseyDB::Currency->retrieve(currencies_id => $quote->{currency});	
	my $merchantid = $ottcurrency->merchantid;
	my $hdfccode = $ottcurrency->hdfccode;
	my $terminalid = $ottcurrency->terminalid;
		
	my $uuid = new Data::UUID;
	my $trackid = $uuid->create_str;
	
	my $ua = LWP::UserAgent->new;
	my $resp = $ua->request(POST $app->config_param('PassthroughURL'), [
		respurl => $app->config_param('ResponseURL'),
		errurl => $app->config_param('ErrorURL'),
		rsrcpath => $app->config_param('ResourcePath'),
		alias => $terminalid,
		currency => $hdfccode,
		amount => $payable,
		trackid => $trackid,
		udf1 => $qid,
		udf2 => $quote->{lead},
		udf3 => $quote->{userid},
		udf4 => $ottcurrency->currencycode,
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
	open my $sickfh, ">", "/tmp/HDFCLog_thanks.txt";
	print $sickfh '<pre>' . Dumper($params) . '</pre>';
	
	my $qrystr = join('&', map {
		if (/^\./) {
			();
		}
		else {
			$_ . '=' . $params->{$_};
		}
	} keys %$params);
	
	
	print $sickfh "\n$qrystr\n";
	close($sickfh);

	return 'REDIRECT=' . 'http://www.travellers-palm.com/thanks' . '?' . $qrystr;
}

sub thanks {
	
	my $app = shift;
	my $q = $app->query;

	my $tpl = $app->load_tmpl('payment_thanks.tpl');
	$tpl->param(
		qid => $q->param('udf1'),
		lead => $q->param('udf2'),
		email => $q->param('udf3'),
		currency => $q->param('udf4'),
		refid => $q->param('ref'),
		tranid => $q->param('tranid'),
		amt => $q->param('amt'),
	);

	return $tpl->output;
}

sub failure {
	
	my $app = shift;
	my $q = $app->query;

	my @params = $q->param();
	return '<pre>' . Dumper(\@params) . '</pre>';	
}
1;
