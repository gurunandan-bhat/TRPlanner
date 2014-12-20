#! /usr/bin/perl

use strict;
use warnings;

use lib qw {../private/traveljadoo/lib/};

use Odyssey::Amend;
use Odyssey::Constants;

my $app = Odyssey::Amend->new(
	cfg_file => $Odyssey::Constants::confdir . 'Odyssey.conf',
);

$app->run();

# Now on Git!!
