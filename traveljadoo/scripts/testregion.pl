#!/usr/bin/perl

use strict;
use warnings;

use Carp;

use lib qw{../lib/};

use OdysseyDB::Region;

while (<>) {
	chomp;
	my $region = OdysseyDB::Region->retrieve(regions_id => $_);

	print $region->title . " passes through:\n";
	foreach ($region->itineraries) {
		print $_->title . "\n";
	}
}