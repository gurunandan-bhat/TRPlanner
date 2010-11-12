package OdysseyDB::Theme;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('themes');

__PACKAGE__->columns(Primary => 'themes_id');
__PACKAGE__->columns(Others => qw{
	title
	oneliner
	introduction
	theme
	metatype
	descr
	keywords
	url
});

__PACKAGE__->has_many(subthemes => 'OdysseyDB::SubTheme');

1;
