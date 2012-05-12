#!/usr/bin/perl

use strict;
use warnings;

use DBI;

my $dbh = DBI->connect(
	'dbi:Sybase:server=Odyssey;database=Jadoo_2006', 
	'sa', 
	'', 
	{
		PrintError => 0, 
		RaiseError => 1, 
		ShowErrorStatement => 1, 
		AutoCommit => 1,
	}
) or die "Cannot Connect to Data File";

my $sth = $dbh->prepare("exec p_RouteFinder '08/29/2008 09:00', 2, 103, 3, 1");
$sth->execute;

while (my $row = $sth->fetchrow_hashref) {
	for (keys %$row) {
		print $_ . "\n";
	}
	last;
}

exit;

