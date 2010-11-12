package OdysseyDB::NearCity;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('nearcities');

__PACKAGE__->columns(Primary => 'nearcities_id');
__PACKAGE__->columns(Others => qw{
	maincities_id
	cities_id
	orderno
});

__PACKAGE__->has_a(maincities_id => 'OdysseyDB::City');

1;
