package RailDB::TrainTypes;

use strict;
use warnings;

use lib qw{../};

use base qw(RailDB);

our $VERSION = '0.01';

__PACKAGE__->table('zz_traintypes');

__PACKAGE__->columns(Primary => 'id');
__PACKAGE__->columns(Others => qw{
	name 
	url 
	field 
	formaction 
	active
});

__PACKAGE__->has_many(trains => 'RailDB::Trains');

1;
