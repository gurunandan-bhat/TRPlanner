package OdysseyDB::ImageCategories;

use strict;
use warnings;

use lib qw{/home3/travelja/myperl/lib /home3/travelja/traveljadoo/lib};
use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('imagecategories');

__PACKAGE__->columns(Primary => 'imagecategories_id');
__PACKAGE__->columns(Others => qw{
	imagecategory
});
