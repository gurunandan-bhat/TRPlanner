package OdysseyDB::HotelCategory;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('addresscategories');

__PACKAGE__->columns(Primary => 'addresscategories_id');
__PACKAGE__->columns(Others => qw{
	addressbook_id
	categories_id	
});

__PACKAGE__->has_a(addressbook_id => 'OdysseyDB::Hotel');
__PACKAGE__->has_a(categories_id => 'OdysseyDB::Category');

1;
