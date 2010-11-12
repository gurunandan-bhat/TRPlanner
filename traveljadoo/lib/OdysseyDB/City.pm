package OdysseyDB::City;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('cities');

__PACKAGE__->columns(Primary => 'cities_id');
__PACKAGE__->columns(Others => qw{
	citycode
	city
	countries_id
	oneliner
	generalinfo
	gettingthere
	whattosee
	excursions
	courier
	writeup
	nighthalt
	pic1
	pic2
	states_id
	bestairporta_cities_id
	bestairportb_cities_id
	bestairportc_cities_id
	beststationa_cities_id
	beststationb_cities_id
	beststationc_cities_id
	bestcarhirea_cities_id
	bestcarhireb_cities_id
	bestcarhirec_cities_id
	airport
	railway
	budgethotels_id
	luxuryhotels_id
	defaultdays
	webwriteup
	latitude
	longitude
	filterfield
	metatype
	descr
	keywords
	url
});

__PACKAGE__->has_a(countries_id => 'OdysseyDB::Country');
__PACKAGE__->has_a(states_id => 'OdysseyDB::State');

__PACKAGE__->has_many(services => 'OdysseyDB::Service');
__PACKAGE__->has_many(hotels => 'OdysseyDB::Hotel');
__PACKAGE__->has_many(tempnearcities => 'OdysseyDB::NearCity', {order_by => 'orderno'});
__PACKAGE__->has_many(itineraries => ['OdysseyDB::ItineraryCity' => 'fixeditin_id']);
__PACKAGE__->has_many(subthemes => ['OdysseyDB::SubThemeCities' => 'subthemes_id']);


sub nearcities {
	my $city = shift;
	return map __PACKAGE__->retrieve($_->cities_id), $city->tempnearcities;
}

__PACKAGE__->set_sql(randomcities => qq{
	select distinct
		cities.cities_id,
		cities.city
	from
		cities,
		defaulthotels
	where
		cities.nighthalt = 1 and
		cities.countries_id = 200 and
		defaulthotels.cities_id = cities.cities_id
	order by
		2
});

__PACKAGE__->set_sql(webhotelcities => qq{
	select distinct
		cities.cities_id,
		cities.city
	from
		vw_hoteldetails,
		addresscategories,
		cities
	where
		addresscategories.categories_id = 27 and
		addresscategories.addressbook_id = vw_hoteldetails.addressbook_id and
		vw_hoteldetails.cities_id = cities.cities_id
	order by 
		2
});

__PACKAGE__->set_sql(webhotelcities_bystate => qq{
	select distinct
		cities.cities_id,
		cities.city
	from
		vw_hoteldetails,
		addresscategories,
		cities
	where
		addresscategories.categories_id = 27 and
		addresscategories.addressbook_id = vw_hoteldetails.addressbook_id and
		vw_hoteldetails.cities_id = cities.cities_id and
		cities.states_id = ?
	order by 
		2
});

1;
