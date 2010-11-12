package OdysseyDB::ItineraryCity;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('cityfixeditin');

__PACKAGE__->columns(Primary => 'cityfixeditin_id');
__PACKAGE__->columns(Others => qw{
	cities_id
	fixeditin_id
});

__PACKAGE__->has_a(fixeditin_id => 'OdysseyDB::Itineraries');
__PACKAGE__->has_a(cities_id => 'OdysseyDB::City');


1;

