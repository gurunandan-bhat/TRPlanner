use strict;
use warnings;

use lib qw{../traveljadoo/lib/};

use Rail::Trains;
use Odyssey::Constants;

my $app = Rail::Trains->new({
	cfg_file => $Odyssey::Constants::confdir . 'Odyssey.conf',
});

$app->run;
