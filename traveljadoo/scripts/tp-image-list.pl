#! /usr/bin/perl 

use strict;
use warnings;

use lib qw{../lib};

use File::Find;
use Image::Size;
use Text::CSV_XS;

my $dir = '/home/tpcom/public_html/images';

my $csv = Text::CSV_XS->new();

my $wanted = sub {

	return if -d;
	my $fsize = -s;
	my $dir = $File::Find::dir;
	my $fname = $_;
	my ($width, $height, $type) = imgsize($_);
	
	if ($csv->combine($dir, $fname, $type, $width, $height, $fsize)) {
		print $csv->string . "\n";
	}
	else {
		die 'Cannot combine: ' . $csv->error_string;
	}
};

find($wanted, $dir);

exit 0;
