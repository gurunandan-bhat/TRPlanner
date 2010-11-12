#!/usr/bin/perl

use strict;
use warnings;

use DBI;

my $dbh = DBI->connect('dbi:Sybase:server=Home;database=Jadoo_2006', 'sa', 'sa123');
$dbh->syb_date_fmt('ISO');

my $sth = $dbh->prepare("exec p_RouteFinder '12/31/2009 09:00', 2, 103, 3, 1");
$sth->execute;

while (my $rec = $sth->fetchrow_hashref) {
	for (sort keys %$rec) {
		print "$_:\t" . $rec->{$_} . "\n";
	}
	print "#####################\n";
}
