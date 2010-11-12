package OdysseyDB::SubTheme;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('subthemes');

__PACKAGE__->columns(Primary => 'subthemes_id');
__PACKAGE__->columns(Others => qw{
	themes_id
	title
	oneliner
	introduction
	subtheme
	url
});

__PACKAGE__->has_a(themes_id => 'OdysseyDB::Theme');
__PACKAGE__->has_many(cities => ['OdysseyDB::SubThemeCities' => 'cities_id']);

1;
