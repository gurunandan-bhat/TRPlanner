package OdysseyDB::Quotation;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('quotations');

__PACKAGE__->columns(Primary => 'quotations_id');
__PACKAGE__->columns(Others => qw{
	quotationdate
	paxname
	numpax
	numsingles
	numdoubles
	numtriples
	numtwins
	extrabed
	dateofarrival
	startdate
	startcities_id
	endcities_id
	mealplans_id
	guide
	hoteltypes_id
	entrancefees
	flightno
	placefrom
	eta
	web
	trial
});

__PACKAGE__->has_many(quocities => 'OdysseyDB::QuotationCity');
__PACKAGE__->has_many(quoaccommodation => 'OdysseyDB::QuotationAccommodation');

1;
