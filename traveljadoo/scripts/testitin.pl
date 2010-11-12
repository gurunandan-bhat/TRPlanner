#!/usr/bin/perl

use strict;
use warnings;

use Carp;

use lib qw{../lib/};

use OdysseyDB::Itineraries;

while (<>) {
	chomp;
	my $itin = OdysseyDB::Itineraries->retrieve(fixeditin_id => $_);

	print $itin->title . " passes through:\n";
	foreach ($itin->cities) {
		print $_->city . "\n";
	}
}