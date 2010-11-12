#!/usr/bin/perl

use strict;
use warnings;

use ex::lib qw{../lib/};

use OdysseyDB::City;

while (my $stateid = <>) {

	chomp $stateid;
	
	foreach ( OdysseyDB::City->search_webhotelcities_bystate($stateid) ) {
		print $_->city . "\n";
	}
}
