package OdysseyDB::Country;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('countries');

__PACKAGE__->columns(Primary => 'countries_id');
__PACKAGE__->columns(Others => qw{
	country
	isd
	gmt
	countrycode
	writeup
	currencies_id	
});

__PACKAGE__->has_many(states => 'OdysseyDB::State');
__PACKAGE__->has_many(cities => 'OdysseyDB::City');
__PACKAGE__->has_many(hotels => 'OdysseyDB::Hotel');

1;

