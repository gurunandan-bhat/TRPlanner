#!/usr/bin/perl;

use strict;
use warnings;

use ex::lib qw(../lib);

use OdysseyDB::Itineraries;

use String::Dirify;
use Data::Dumper;

my %log = ();

my $region_it = OdysseyDB::Itineraries->retrieve_all;

while (my $region = $region_it->next) {

	my $title = $region->title;

	my $url = String::Dirify->dirify($title);
	
	if (exists $log{$url}) {
		my $idx = ++$log{$url};
		$url .= "_$idx"; 
	}
	else {
		$log{$url} = 1;
	}

	$region->set(url => $url);
	$region->update;
	
	print "$url\n";
}

exit;
