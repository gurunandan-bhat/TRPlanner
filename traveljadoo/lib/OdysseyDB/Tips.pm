package OdysseyDB::Tips;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('fixeditintips');

__PACKAGE__->columns(Primary => 'fixeditintips_id');
__PACKAGE__->columns(Others => qw{
	fixeditin_id
	orderno
	title
	tip
});

__PACKAGE__->has_a(fixeditin_id => 'OdysseyDB::Itineraries');

1;
