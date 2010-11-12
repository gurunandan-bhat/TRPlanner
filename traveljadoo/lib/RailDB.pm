package RailDB;

use strict;
use warnings;

use lib qw{../lib};

use base qw(Class::DBI::Sybase);
use Config::Simple;
use Odyssey::Constants;

our $VERSION = '0.01';

my $cfg = new Config::Simple($Odyssey::Constants::confdir . 'Odyssey.conf');

my $dbserver = $cfg->param('default.DBServer');
my $dbname 	 = $cfg->param('default.DBName');
my $dbuser	 = $cfg->param('default.User');

my $dbpasswd = $cfg->param('default.Password');

my $dsn = "dbi:Sybase:server=$dbserver;database=$dbname";

__PACKAGE__->set_db(
	'Main',
	$dsn,
	$dbuser,
	$dbpasswd,
	{AutoCommit => 1, RaiseError => 0},
);

1;
__END__
