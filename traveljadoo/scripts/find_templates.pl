#!/usr/bin/perl

use strict;
use warnings;

use File::Find;

my @dirs = qw{/home/nandan/workspace/TRPlanner/traveljadoo/lib};

my %templates;

my $cback = sub {
	
	return unless /\.pm$/;
	
	open my $fh, "<", $File::Find::name;
	
	while (<$fh>) {

		next unless />load_tmpl\((.*)\)/;
		my @strngs = split('\,', $1);
		
		(my $tpl = $strngs[0]) =~ s/'//g;
		$templates{$tpl} = 1;
	}
};

File::Find::find($cback, @dirs);

foreach (sort keys %templates) {
	print "$_\n";
}

exit;

