package FlightsDB;

use strict;
use warnings;

use base qw(Class::DBI);

our $VERSION = '0.01';

my ($dsn, $user, $passwd) = _getSQLConfig();

FlightsDB->set_db(
	'Main',
	$dsn,
	$user,
	$passwd,
	{PrintError => 1, AutoCommit => 1, RaiseError => 1}, 
);

sub _getOraConfig {
	
	my $dbhost 	 = 'localhost';
	my $dbsid 	 = 'xe';
	my $dbuser	 = 'trains';
	my $dbpasswd = 'ip31415';
	
	my $dsn = "dbi:Oracle:host=$dbhost;sid=$dbsid";

	return ($dsn, $dbuser, $dbpasswd);
}

sub _getSQLConfig {
	
	my $dbserver = 'Home';
	my $dbname 	 = 'Jadoo_2006';
	my $dbuser	 = 'sa';
	my $dbpasswd = 'ip31415';
	
	my $dsn = "dbi:Sybase:server=$dbserver;database=$dbname";

	return ($dsn, $dbuser, $dbpasswd);
}

1;
__END__
