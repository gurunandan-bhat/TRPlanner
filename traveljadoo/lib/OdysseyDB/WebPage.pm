package OdysseyDB::WebPage;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('webpages');

__PACKAGE__->columns(Primary => 'webpages_id');
__PACKAGE__->columns(Others => qw{
	pagename
	url
	metatype
	descr
	keywords
});

1;
