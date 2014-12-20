package FlightsDB::Schedule;

use strict;
use warnings;

use lib qw(../);
use base qw(OdysseyDB);

our $VERSION = '0.01';

__PACKAGE__->table('zz_flights');

__PACKAGE__->columns(Primary => qw{flights_id});
__PACKAGE__->columns(Others => qw{
	flightcode
	flightsource
	flightsourcecode
	flightstarttime
	flightdestination
	flightdestinationcode
	flightendtime
	flightairline
	flightvia
	flightviacode
	flightwef
	flightwet
	flightstops
	flightcraft
	flightrunson
});

1;
