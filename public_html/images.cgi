#! /usr/bin/perl

use strict;
use warnings;

use lib qw{../traveljadoo/lib};

use Odyssey::Images;
use Odyssey::Constants;

my $app = Odyssey::Images->new({
	cfg_file => $Odyssey::Constants::confdir . 'Odyssey.conf',
});
$app->run();

# Now on Git!
