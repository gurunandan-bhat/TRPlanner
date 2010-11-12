package OdysseyDB::HotelRaw;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('hotels');

__PACKAGE__->columns(Primary => 'addressbook_id');
__PACKAGE__->columns(Others => qw{
	description
	image1
	showhotel
	image2
	image3
	image4
	starcategories_id
	cuisine
	bars
	restaurants
	checkout
	accessrail
	accessair
	accessbus
	advantage
	logo
	rooms
	ac
	roomfacility
	otherfacility
	services
	creditcards
	fhra
	WebWriteUp1
	WebWriteUp2
	url
	Metatype
	Descr
	Keywords
});
