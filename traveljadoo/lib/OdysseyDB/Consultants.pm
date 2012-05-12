package OdysseyDB::Consultants;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('consultants');

__PACKAGE__->columns(Primary => 'consultants_id');
__PACKAGE__->columns(Others => qw{
	consultant
	email
	addressbook_id
	writeup
	pwd
	active
});
1;
