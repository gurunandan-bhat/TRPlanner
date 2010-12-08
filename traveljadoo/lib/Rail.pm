package Rail;


use strict;
use warnings;

use base qw(CGI::Application);

use CGI::Application::Plugin::Config::Simple;
use CGI::Application::Plugin::Session;
use CGI::Application::Plugin::DBH qw{dbh_config dbh};

use Date::Manip;

our $VERSION = '0.01';

sub cgiapp_init {
	
	my ($app, $params) = @_;
	
	$app->config_file($params->{cfg_file});
	$app->tmpl_path( $app->config_param('default.TemplatePath') );

	CGI::Session->name($app->config_param('Default.CookieName'));

	$app->session_config(
		CGI_SESSION_OPTIONS => [
			'driver:sqlite',
			$app->query,
			{
				DataSource => $app->config_param('default.LocalDBFile'),
				TableName => 'cgisessions',
				IdColName => 'sessionid',
				DataColName => 'sessiondata',
				ColumnType => 'binary',
			},
		],
	);

	$app->dbh_config($app->config_param('UserDBDSN'), '', '',);
}

sub errhndlr {
	my $app = shift;
	my $err = shift;
	
	my $tpl = $app->load_tmpl('railerror.tpl');

	if (ref($err) eq 'HASH') {
		$tpl->param(CLASS => $err->{type});
		$tpl->param(MSG => $err->{msg});
	}
	else {
		my $errstr = 'Unexpected System Error.<br />';
		$tpl->param(CLASS => 'error');
		$tpl->param(MSG => "$errstr\n$err");
	}
	return $tpl->output;
}

1;
