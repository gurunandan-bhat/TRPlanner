use strict;
use warnings;

use lib qw{../traveljadoo/lib};

use Odyssey::Init;
use Odyssey::Constants;

my $app = Odyssey::Init->new({
	cfg_file => $Odyssey::Constants::confdir . 'Odyssey.conf',
});

$app->run();
