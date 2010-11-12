package OdysseyDB::QuotationTicket;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('quotickets');

__PACKAGE__->columns(Primary => 'quotickets_id');
__PACKAGE__->columns(Others => qw{
	tickets_id
	quocities_id
	nooftickets
	traveldate
	from_cities_id
	to_cities_id
	trainno
	flightno
	class_id
	etd
	eta
	quotations_id
});

__PACKAGE__->has_a(quocities_id => 'OdysseyDB::QuotationCity');

1;
