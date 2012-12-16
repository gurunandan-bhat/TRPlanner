#!/usr/bin/perl

use strict;
use warnings;

use lib qw{../lib/};

use OdysseyDB::State;

use File::Find;
use Getopt::Long;
use File::Inplace;

my $dir = '.';
my $column = 0;

my @url;

GetOptions(
	'directory=s' => \$dir,
);

my $wanted = sub {

	return unless (-f and -r _);
	return unless /^ammap\_data\_(\d+)\.xml$/;

	print "$_\n";
	
	fix_urls($File::Find::name);
	
};

File::Find::find($wanted, '/home/guru/Devel/TRPlanner/public_html/beta/maps');

exit;

sub fix_urls {
	
	my $fname = shift;
	my $regexp = 'hotel\.cgi\?mode\=statehotels\&sid\=(\d+)';

	my $ed = File::Inplace->new(file => $fname, suffix => '.bak', chomp => 1);
	while (my ($line) = $ed->next_line) {
		
		next unless ($line =~ /$regexp/);

		my $stateid = $1;
		if (! defined $url[$stateid]) {
			my $state = OdysseyDB::State->retrieve(states_id => $stateid);
			$url[$stateid] = $state->url;
		}
		
		(my $newline = $line) =~ s/$regexp/\/state\/$url[$stateid]/;
		print $newline;

		$ed->replace_line($newline);
	}
	$ed->commit();
}  
