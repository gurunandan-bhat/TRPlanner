use strict;
use warnings;

use lib qw{../traveljadoo/lib/};

use Odyssey::SmartRouteFinder;
use Odyssey::Constants;

my $app = Odyssey::SmartRouteFinder->new({
	cfg_file => $Odyssey::Constants::confdir . 'Odyssey.conf',
});

$app->run;
