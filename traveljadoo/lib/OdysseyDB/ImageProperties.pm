package OdysseyDB::ImageProperties;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('imageproperties');

__PACKAGE__->columns(Primary => 'imageproperties_id');
__PACKAGE__->columns(Others => qw{
	imagecategories_id
	imagetypes_id
	imagepattern
	imagewidth
	imageheight
});
