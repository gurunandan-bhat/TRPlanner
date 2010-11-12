package OdysseyDB::SubThemeCities;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('citythemes');

__PACKAGE__->columns(Primary => 'citythemes_id');
__PACKAGE__->columns(Others => qw{
	cities_id
	themes_id
	subthemes_id
	citysubtheme
});

__PACKAGE__->has_a(subthemes_id => 'OdysseyDB::SubTheme');
__PACKAGE__->has_a(cities_id => 'OdysseyDB::City');


1;
