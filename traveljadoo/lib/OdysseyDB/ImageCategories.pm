package OdysseyDB::ImageCategories;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('imagecategories');

__PACKAGE__->columns(Primary => 'imagecategories_id');
__PACKAGE__->columns(Others => qw{
	imagecategory
});
