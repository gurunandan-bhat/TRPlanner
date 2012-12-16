#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{say};

use DBI;
use Data::Dumper;

my $dbh = DBI->connect('dbi:Sybase:server=Odyssey;database=Jadoo_2006', 'jadoo', 'ip31415')
	|| die "Cannot connect to database: $DBI::errstr";

my $qry = "select * from web order by web_id";
my $sth = $dbh->prepare($qry);

$sth->execute;
while (my $row = $sth->fetchrow_hashref('NAME_lc')) {
	
	say $row->{web_id} . "\t" . $row->{writeup};
}

