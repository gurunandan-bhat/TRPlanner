#!/usr/bin/perl

use strict;
use warnings;

use ex::lib qw{../lib};

use DBI;

my $imgdir = '/home/tpcom/public_html/images/';
open my $imgdh, $imgdir or die "Cannot Open $imgdir: $!\n";

my $pattern = 'city_(\d+)_collage.gif';

while (my $fname = readdir($imgdh)) {
	
	next unless $fname =~ /$pattern/;
	print "$fname\n";
}
