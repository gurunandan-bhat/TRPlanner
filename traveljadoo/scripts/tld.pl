#!/usr/bin/perl

use strict;
use warnings;

use URI;

while (<>) {
	
	chomp;
	my $uri = URI->new($_);
		
	if ($uri->host =~ /(.*)\.(.*)/) {
		print "Matched: $2\n"; 
	}
	else {
		print "No Match Found\n";
	}
}

exit;
