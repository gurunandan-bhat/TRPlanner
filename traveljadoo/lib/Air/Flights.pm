package Air::Flights;

use strict;
use warnings;

use lib qw{../};

use base qw{Air};

use OdysseyDB::City;
use Date::Manip;

my $weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
my $carriers = {
	CD => ''
};
sub setup {

	my $app = shift;
	
	$app->mode_param('mode');
	$app->run_modes(
		start => 'start',
		findflights => 'findflights',
	);
	
	$app->start_mode('start');
	$app->error_mode('errhndlr');
}

sub start {

	my $app = shift;

	my $tpl = $app->load_tmpl('flightindex.tpl', die_on_bad_params => 0);

	my $dbh = OdysseyDB::City->db_Main();
	my $qry = qq{
		select distinct
			cities.cities_id,
			cities.city
		from
			flightsectorfaresindia,
			cities
		where
			cities.countries_id = 200 and
			flightsectorfaresindia.from_cities_id = cities.cities_id
		order by
			2
	};
	
	my $sth = $dbh->prepare($qry);
	$sth->execute;
	
	my @airports;
	while (my $data = $sth->fetchrow_hashref("NAME_lc")) {
	
		push @airports, {
			AIRPORTCODE => $data->{cities_id},
			AIRPORTNAME => $data->{city},
		};
	}
	$tpl->param(AIRPORTS => \@airports);
	
	return $tpl->output;
}

sub findflights {
	
	my $app = shift;

	my $src = $app->query->param('src');
	my $dest = $app->query->param('dest');
	
	die({type => 'error', msg => 'Please provide the City you want to start from and your destination'})
		unless ($src and $dest);

	my $srcname = OdysseyDB::City->retrieve(cities_id => $src)->city;
	my $destname = OdysseyDB::City->retrieve(cities_id => $dest)->city;
			
	my $qry = "select distinct
					flightno,
					departure,
					duration,
					days 
				from
					flightsectorfaresindia
				where
					from_cities_id = ? and
					to_cities_id = ?
				order by
					duration";
	my $dbh = OdysseyDB::City->db_Main();
	my $sth = $dbh->prepare($qry);
	$sth->execute($src, $dest);
	
	my %found;
	my @options;
	while (my $row = $sth->fetchrow_hashref("NAME_lc")) {
		
		(my $flt = $row->{flightno}) =~ s/\s+//g;
		push @options, {
			flightno => $row->{flightno},
			carrier => $row->{flightno},
			departure => UnixDate($row->{departure}, '%H:%m'),
			duration => $row->{duration},
			operateson => get_days($row->{days}),
		} unless defined $found{$flt};
		$found{$flt} = 1;
	}
	
	$qry = qq{
		select distinct
			cities.cities_id,
			cities.city
		from
			flightsectorfaresindia,
			cities
		where
			cities.countries_id = 200 and
			flightsectorfaresindia.from_cities_id = cities.cities_id
		order by
			2
	};
	
	$sth = $dbh->prepare($qry);
	$sth->execute;
	
	my @airports;
	while (my $data = $sth->fetchrow_hashref("NAME_lc")) {
	
		push @airports, {
			AIRPORTCODE => $data->{cities_id},
			AIRPORTNAME => $data->{city},
		};
	}

	my $tpl = $app->load_tmpl('flightindex.tpl', die_on_bad_params => 0);
	$tpl->param(
		AIRPORTS => \@airports,
		SUBMITTED => 1,
		FLIGHTS => \@options,
		SRCID => $src,
		DESTID => $dest,
		SRCNAME => $srcname,
		DESTNAME => $destname,
	);
	
	return $tpl->output;
}

sub get_days {
	
	my $runson = shift;
	return 'All Days' if ($runson == 127);
	
	my $i = 1;
	my @rdays;
	
	for (@{$weekdays}) {
		push @rdays, $_ if ($i & $runson);
		$i = $i << 1;
	}
	return join ', ', @rdays;
}

1;
