package OdysseyDB::ImageTypes;

use strict;
use warnings;

use lib qw{/home3/travelja/myperl/lib /home3/travelja/traveljadoo/lib};
use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('imagetypes');

__PACKAGE__->columns(Primary => 'imagetypes_id');
__PACKAGE__->columns(Others => qw{
	imagetype
});
