#!/usr/bin/perl

use strict;
use warnings;

use Carp;

use lib qw{../lib/};

use OdysseyDB::SubTheme;

while (<>) {
	chomp;
	my $stheme = OdysseyDB::SubTheme->retrieve(subthemes_id => $_);

	next unless $stheme;

	print $stheme->title . " passes through:\n";
	foreach ($stheme->cities) {
		print $_->city . "\n";
	}
}
