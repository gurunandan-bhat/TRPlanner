package OdysseyDB::QuotationCity;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('quocities');

__PACKAGE__->columns(Primary => 'quocities_id');
__PACKAGE__->columns(Others => qw{
	quotations_id
	datein
	dateout
	tocities_id
	quoticketsok
	quoaccommodationok
	quosightseeingok
	quotransfersok
	errorno
	warndesc
	errordesc
});


__PACKAGE__->has_a(quotations_id => 'OdysseyDB::Quotation');
__PACKAGE__->has_many(quotickets => 'OdysseyDB::QuotationTicket');
__PACKAGE__->has_many(quohotels => 'OdysseyDB::QuotationAccommodation');


1;
