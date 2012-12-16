#!/usr/bin/perl

use Text::Balanced qw/extract_bracketed extract_multiple/;
#
#while (<>) {
#	chomp;
#	my ($extract, $remainder, $prefix) = extract_bracketed($_, '{}');
#	print "Prefix: $prefix\n";
#	print "Extract: $extract\n";
#	print "Remainder: $remainder\n";
#}

use Data::Dumper;

while (<>) {
	chomp;
	my @data = extract_multiple($_, [\&extract_bracketed]);
	print Dumper(\@data);
}