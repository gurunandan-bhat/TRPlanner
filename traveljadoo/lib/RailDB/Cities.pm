package RailDB::Cities;

use strict;
use warnings;

use lib qw{../};

use base qw(RailDB);

our $VERSION = '0.01';

__PACKAGE__->table('trainstations');

__PACKAGE__->columns(Primary => 'trainstations_id');
__PACKAGE__->columns(Others => qw{
	station
	railwaycode
	stationname
	cities_id
	in_use
	flag1
});

# __PACKAGE__->add_constructor(our_cities => 'cities_id > 0');

1;
__END__
