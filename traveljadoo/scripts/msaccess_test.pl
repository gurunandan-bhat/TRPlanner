#!/usr/bin/perl

use strict;
use warnings;

use DBI;

my $dbserver = 'OdysseyLive';
my $dbname 	 = 'odyssey';
my $dbuser	 = 'odyssey';
my $dbpasswd = '6pcILRGjSi60';

my $dsn = "dbi:Sybase:server=$dbserver;database=$dbname";

my $dbh = DBI->connect($dsn,'','', {AutoCommit => 1, RaiseError => 1, PrintError => 1}) or 
              die "Can't connect to $dsn $DBI::errstr\n";

              
my $sth = $dbh->prepare("select * from quotations");
$sth->execute;

while (my $row = $sth->fetchrow_arrayref) {
	print join ' : ', @$row;
	print "\n";
}

$sth->finish;
