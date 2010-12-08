#!/usr/bin/perl

use strict;
use warnings;

use lib qw{../traveljadoo/lib/};

use Odyssey::Payment;
use Odyssey::Constants;

my $app = Odyssey::Payment->new({
	cfg_file => $Odyssey::Constants::confdir . 'Odyssey.conf',
});

$app->run;
