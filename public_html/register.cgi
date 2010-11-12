#! /usr/bin/perl

use strict;
use warnings;

use lib qw{../traveljadoo/lib};

use Odyssey::Constants;
use Odyssey::Register;

my $app = Odyssey::Register->new({
	cfg_file => $Odyssey::Constants::confdir . 'Odyssey.conf',
});

$app->run();
