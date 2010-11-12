package OdysseyDB::State;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('states');

__PACKAGE__->columns(Primary => 'states_id');
__PACKAGE__->columns(Others => qw{
	statecode
	state
	countries_id
	printstate
	oneliner
	writeup	
	webwriteup
	latitude
	longitude
	metatype
	descr
	keywords
	url
});

__PACKAGE__->has_a(countries_id => 'OdysseyDB::Country');

__PACKAGE__->has_many(cities => 'OdysseyDB::City');
__PACKAGE__->has_many(hotels => 'OdysseyDB::Hotel');

__PACKAGE__->set_sql(webhotelstates => qq{
	select distinct
		states.states_id,
		states.state
	from
		vw_hoteldetails,
		addresscategories,
		states
	where
		addresscategories.categories_id = 27 and
		addresscategories.addressbook_id = vw_hoteldetails.addressbook_id and
		vw_hoteldetails.states_id = states.states_id
	order by 2
});


1;
