package RailDB::Trains;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

our $VERSION = '0.01';

__PACKAGE__->table('zz_trains');

__PACKAGE__->columns(Primary => 'shortname');
__PACKAGE__->columns(Others => qw{
	longname
	startname
	startcode
	starttime
	endname
	endcode
	endtime
	runson
	active
	schdupdton
	fareupdton
	recdupdton
	type
	sliproute
	sessionid
});

__PACKAGE__->has_a(type => 'RailDB::TrainTypes');
__PACKAGE__->has_a(sessionid => 'RailDB::Sessions');
__PACKAGE__->has_many(stops => 'RailDB::Schedule');
	
1;
__END__
