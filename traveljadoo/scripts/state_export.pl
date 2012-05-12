#!/usr/bin/perl

use strict;
use warnings;

use lib qw{../lib/};

use OdysseyDB::State;

my @states = map{{
	id => $_->states_id, 
	name => $_->state, 
	lat => $_->latitude, 
	long => $_->longitude,
}} OdysseyDB::State->search_webhotelstates;


use JSON;

my $json = new JSON;
print $json->pretty->encode(\@states);

exit;

