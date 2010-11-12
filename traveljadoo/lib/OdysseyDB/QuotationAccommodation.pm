package OdysseyDB::QuotationAccommodation;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('quoaccommodation');

__PACKAGE__->columns(Primary => 'quoaccommodation_id');
__PACKAGE__->columns(Others => qw{
	hoteladdressbook_id
	ac
	roomtypes_id
	nights
	quocities_id
	quotations_id
});


__PACKAGE__->has_a(quocities_id => 'OdysseyDB::QuotationCity');

1;
