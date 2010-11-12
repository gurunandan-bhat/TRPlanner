package OdysseyDB::Service;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('services');

__PACKAGE__->columns(Primary => 'services_id');
__PACKAGE__->columns(Others => qw{
	service
	description
	addressbook_id
	private
	duration
	defaultorder
	starttime
	active
	cities_id
	tickets_id
	transfer
	transfertypes_id
	writeup
	image
	daysofoperation
	to_cities_id
	owntransport
	recommended
});

__PACKAGE__->has_a(cities_id => 'OdysseyDB::City');

1;
