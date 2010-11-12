package OdysseyDB::Itineraries;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('fixeditin');

__PACKAGE__->columns(Primary => 'fixeditin_id');
__PACKAGE__->columns(Others => qw{
	title
	oneliner
	introduction
	itinerary
	triphighlights
	quotes
	adv
	regions_id
	readytours
	itindates
	inclusions
	prices
	orderno
	duration
	inactivewef
	metatype
	descr
	keywords
	url
});

__PACKAGE__->has_many(cities => ['OdysseyDB::ItineraryCity' => 'cities_id']);
__PACKAGE__->has_many(tips => 'OdysseyDB::Tips', {order_by => 'orderno'});
__PACKAGE__->has_a(regions_id => 'OdysseyDB::Region');

1;
