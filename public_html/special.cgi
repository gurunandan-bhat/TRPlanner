#! /usr/bin/perl

use strict;
use warnings;

use ex::lib qw{../traveljadoo/lib};

use Odyssey::Hotels;
use Odyssey::Constants;

my $app = Odyssey::Hotels->new(
	cfg_file => $Odyssey::Constants::confdir . 'Odyssey.conf',
);
$app->run();

# Now on Git!
