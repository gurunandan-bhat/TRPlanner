#!/usr/bin/perl

use strict;
use warnings;

use lib qw{../traveljadoo/lib/};

use Air::Flights;
use Odyssey::Constants;

my $app = Air::Flights->new(
	cfg_file => $Odyssey::Constants::confdir . 'Odyssey.conf',
);

$app->run;
