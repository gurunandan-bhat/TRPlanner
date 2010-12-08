package Odyssey::Payment;

use strict;
use warnings;

use LWP::UserAgent;
use Data::Dumper;

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
	
	my $ua = LWP::UserAgent->new;
	my $resp = $ua->request(POST $app->config_param('PassthroughURL'), [
		currency => 356,
		amount => 100,
		trackid => '1234509876',
		UDF1 => 'This is a User-defined field',
	]);
	
	if ($resp->is_success) {
		if (my $rdurl = $resp->decoded_content) {
			$app->redirect($rdurl);
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
	
	my @params = $q->param();
	open my $sickfh, ">", "/tmp/HDFCLog.txt";
	print $sickfh '<pre>' . Dumper(\@params) . '</pre>';
	
	$app->redirect('/');	
}

sub failure {
	
	my $app = shift;
	my $q = $app->query;

	my @params = $q->param();
	return '<pre>' . Dumper(\@params) . '</pre>';	
}
1;
