#! /usr/bin/perl

use strict;
use warnings;

use lib qw{../traveljadoo/lib};

use Odyssey::Region;
use Odyssey::Constants;

my $app = Odyssey::Region->new(
	cfg_file => $Odyssey::Constants::confdir . 'Odyssey.conf',
);

$app->run();
