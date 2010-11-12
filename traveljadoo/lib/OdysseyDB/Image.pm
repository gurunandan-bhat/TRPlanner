package OdysseyDB::Image;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('images');

__PACKAGE__->columns(Primary => 'images_id');
__PACKAGE__->columns(Others => qw{
	imagename
	width
	height
	category
	title
	alttag
	srno
	imagecategories_id
	filesize
	type
	imageobjectid
	imagetypes_id
});

# __PACKAGE__->has_a(imagecategories_id => 'OdysseyDB::ImageCategory');
# __PACKAGE__->has_a(imagetypes_id => 'OdysseyDB::ImageType');
