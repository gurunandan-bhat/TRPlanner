package RailDB::Sessions;

use strict;
use warnings;

use lib qw{../};

use base qw(RailDB);

our $VERSION = '0.01';

__PACKAGE__->table('zz_sessions');

__PACKAGE__->columns(Primary => 'id');
__PACKAGE__->columns(Others => qw{
	id
	object
	startedon
	endedon
	status
	remark
});

__PACKAGE__->has_many(trains => 'RailDB::Trains');

1;
