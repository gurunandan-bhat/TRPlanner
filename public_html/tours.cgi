#! /usr/bin/perl

use strict;
use warnings;

use lib qw{../traveljadoo/lib};

use Odyssey::Tours;
use Odyssey::Constants;

my $app = Odyssey::Tours->new(
	cfg_file => $Odyssey::Constants::confdir . 'Odyssey.conf',
);

$app->run();
