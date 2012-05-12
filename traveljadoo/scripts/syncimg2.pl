#!/usr/bin/perl

use strict;
use warnings;

use lib qw{../lib};

use Image::Size;
 
use OdysseyDB::City;
use OdysseyDB::State;
use OdysseyDB::Image;

my $imgdir = '/home/tpcom/public_html/images/';
opendir my $imgdh, $imgdir or die "Cannot Open $imgdir: $!\n";

my $pattern = 'city\_(\d+)\_collage\.gif';

my $fname;
while (defined($fname = readdir($imgdh))) {

	next unless $fname =~ /$pattern/;
	
	next unless	my $city = OdysseyDB::City->retrieve(cities_id => $1);
	next unless my $state = $city->states_id;
	
	my $alt = $city->city . ', ' . $state->state . ', India';
	my ($width, $height) = 	imgsize($imgdir . $fname);
	
	my $title = "City Scenes from " . $alt;

	OdysseyDB::Image->insert({
		imagename => $fname,
		width => $width,
		height => $height,
		category => 'City',
		title => $title,
		alttag => $alt,
		imagecategories_id => $1,
		filesize => -s $imgdir . $fname,
		type => 'collage',
	});
	
}


exit;