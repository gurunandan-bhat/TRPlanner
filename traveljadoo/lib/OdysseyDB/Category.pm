package OdysseyDB::Category;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('categories');

__PACKAGE__->columns(Primary => 'categories_id');
__PACKAGE__->columns(Others => qw{
	description
});

__PACKAGE__->has_many(hotels => ['OdysseyDB::HotelCategory', 'addressbook_id']);

1;
