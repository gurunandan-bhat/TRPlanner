#!/usr/bin/env perl

use strict;
use warnings;

use DBIx::Class::Schema::Loader qw{make_schema_at};
make_schema_at(
	'OdysseyDB::Schema', {
		debug => 1,
		dump_directory => './lib',
		naming => 'current',
		db_schema => 'dbo',
		moniker_map => {
			class => 'myclass',
			classes => 'theirs',
			zz_trains => 'trains',
			zzTrains => 'buses',
		}
    }, [ 
    	'dbi:Sybase:server=Odyssey;database=Jadoo_2006',
    	'jadoo', 
    	'ip31415',
    ],
);