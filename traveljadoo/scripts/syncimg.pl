#!/usr/bin/perl

use strict;
use warnings;

use lib qw{../lib};

use Image::Size;

use OdysseyDB::Itineraries;
use OdysseyDB::City;
use OdysseyDB::State;
use OdysseyDB::Image;

my $imgdir = '/home/tpcom/public_html/images/';
opendir my $imgdh, $imgdir or die "Cannot Open $imgdir: $!\n";

my $pattern = 'rt\_(\d+)\_advert.gif';

my $fname;
while (defined($fname = readdir($imgdh))) {

	next unless $fname =~ /$pattern/;
	
	next unless	my $itin = OdysseyDB::Itineraries->retrieve(fixeditin_id => $1);
	
	my $alt = 'Ready Tour: ' . $itin->title;
	my $title = $alt;

	my ($width, $height) = 	imgsize($imgdir . $fname);
	
	OdysseyDB::Image->insert({
		imagename => $fname,
		width => $width,
		height => $height,
		category => 'Ready Tour',
		title => $title,
		alttag => $alt,
		imagecategories_id => $1,
		filesize => -s $imgdir . $fname,
		type => 'advert',
	});
}

exit;