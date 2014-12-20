package RailDB::Schedule;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

our $VERSION = '0.01';

__PACKAGE__->table('zz_schedule');

__PACKAGE__->columns(Primary => qw{shortname stopcode});
__PACKAGE__->columns(Others => qw{
	stopname
	arrival
	departure
	stopnum
	daynum
	remark
	routenum
	distance
	used
});

__PACKAGE__->has_a(shortname => 'RailDB::Trains');


1;
