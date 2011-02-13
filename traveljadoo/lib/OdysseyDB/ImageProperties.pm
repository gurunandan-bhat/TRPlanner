package OdysseyDB::ImageProperties;

use strict;
use warnings;

use lib qw{/home3/travelja/myperl/lib /home3/travelja/traveljadoo/lib};
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
	imagefolder
});
