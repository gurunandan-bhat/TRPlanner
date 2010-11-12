package OdysseyDB::WebText;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('web');

__PACKAGE__->columns(Primary => 'web_id');
__PACKAGE__->columns(Others => qw{
	srno
	title
	pagename
	writeup
	webpages_id
});

1;
