package OdysseyDB::Image;

use strict;
use warnings;

use lib qw{/home3/travelja/myperl/lib /home3/travelja/traveljadoo/lib};
use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('images');

__PACKAGE__->columns(Primary => 'images_id');
__PACKAGE__->columns(Others => qw{
	imagename
	width
	height
	category
	type
	imagecategories_id
	imagetypes_id
	imageobjectid
	title
	alttag
	srno
	filesize
});
