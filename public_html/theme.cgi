#! /usr/bin/perl

use strict;
use warnings;

use lib qw{../traveljadoo/lib};

use Odyssey::Themes;
use Odyssey::Constants;

my $app = Odyssey::Themes->new({
	cfg_file => $Odyssey::Constants::confdir . 'Odyssey.conf',
});

$app->run();
