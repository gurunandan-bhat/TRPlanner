package Odyssey::Payment;

use strict;
use warnings;

use LWP::UserAgent;
use Data::Dumper;
use Regexp::Common qw{URI};
use lib qw{../};
use base qw(Odyssey);

sub setup {
	my $app = shift;
	
	$app->mode_param('mode');

	$app->run_modes(
		index => 'index',
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

sub togateway {
	
	my $app = shift;
	
	my $quoteid = '1234509876';
	my $tourid = 'abcdefkjihg';
	my $amount = 500;
	my $currency = 356;
	
	my $uuid = new Data::UUID;
	my $trackid = $uuid->create_str;
	
	my $ua = LWP::UserAgent->new;
	my $resp = $ua->request(POST $app->config_param('PassthroughURL'), [
		respurl => $app->config_param('ResponseURL'),
		errurl => $app->config_param('ErrorURL'),
		rsrcpath => $app->config_param('ResourcePath'),
		alias => $app->config_param('MerchantAlias'),
		currency => 356,
		amount => 100,
		trackid => $trackid,
		udf1 => $quoteid,
		udf2 => $tourid,
	]);
	
	if ($resp->is_success) {
		if (my $rdurl = $resp->decoded_content) {
			if ($rdurl =~ /$RE{URI}{HTTP}{-scheme => 'https'}/) {
				$app->redirect($rdurl) ;
			}
			else {
				die({type => 'error', msg => {'Got an Invalid URL from Gateway. Aborting'}});
			}
		}
		else {
			die({type => 'error', msg => {'Got NULL response from URL Converter. Aborting'}});
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
	open my $sickfh, ">", "/tmp/HDFCLog.txt";
	print $sickfh '<pre>' . Dumper($params) . '</pre>';
	
	$app->redirect('thanks');	
}

sub thanks {
	
	my $app = shift;
	my $q = $app->Vars;

	my $params = $q->Vars;
	return '<p>Thank You</p><br /><pre>' . Dumper($params) . '</pre>';
}

sub failure {
	
	my $app = shift;
	my $q = $app->query;

	my @params = $q->param();
	return '<pre>' . Dumper(\@params) . '</pre>';	
}
1;
