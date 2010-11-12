package Rail::Trains;

use strict;
use warnings;

use lib qw{../};

use base qw(Rail);

use RailDB::Cities;
use RailDB::Trains;
# use Data::Dumper;

my $weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

sub setup {

	my $app = shift;
	
	$app->mode_param('mode');
	$app->run_modes(
		start => 'start',
		findtrains => 'findtrains',
		getschedule => 'getschedule',
	);
	
	$app->start_mode('start');
	$app->error_mode('errhndlr');
}

sub start {

	my $app = shift;

	my $tpl = $app->load_tmpl('railindex.tpl', die_on_bad_params => 0, loop_context_vars => 1);

	my $dbh = RailDB::Trains->db_Main();
	my $qry = qq{
		select distinct
			cities.cities_id,
			cities.city
		from
			trainstations,
			cities
		where
			trainstations.cities_id > 0 and
			trainstations.cities_id = cities.cities_id
		order by
			2
	};
	
	my $sth = $dbh->prepare($qry);
	$sth->execute;
	
	my @stations;
	while (my $data = $sth->fetchrow_hashref("NAME_lc")) {
	
		push @stations, {
			STATIONCODE => $data->{cities_id},
			STATIONNAME => $data->{city},
		};
	}
	
#	return '<pre>' . Dumper(\@stations) . '</pre>';
	
	$tpl->param(STATIONS => \@stations);
	
	return $tpl->output;
}

sub findtrains {
	
	my $app = shift;
	
	my $src = $app->query->param('src');
	my $dest = $app->query->param('dest');
	
	my $dbh = RailDB::Trains->db_Main();
	
	my $qry = qq{
		select
			s1.shortname,
			s1.stopname src,
			s1.departure,
			s2.stopname dest,
			s2.arrival,
			s2.daynum - s1.daynum nights,
			s2.distance - s1.distance dist
		from
			zz_schedule s1,
			trainstations t1,
			zz_schedule s2,
			trainstations t2
		where
			s1.shortname = s2.shortname and
			s1.stopcode = t1.railwaycode and
			t1.cities_id = ? and
			s2.stopcode = t2.railwaycode and
			t2.cities_id = ? and
			s2.stopnum > s1.stopnum and
			s1.remark is null and
			s2.remark is null
		order by
			1, 7 desc 
	};
	my $sth = $dbh->prepare($qry);
	$sth->execute($src, $dest);
	
	my @routes;
	my $last;
	while (my $data = $sth->fetchrow_hashref("NAME_lc")) {

		my $shortname = $data->{shortname};
		next if ($shortname eq $last);
		
		my $train = RailDB::Trains->retrieve(shortname => $shortname);
		next unless $train;
		$data->{longname} = $train->longname;
		$data->{runson} = get_days($train->runson);		
		push @routes, $data;
		$last = $shortname;
	}
	
	my $tpl = $app->load_tmpl('railindex.tpl', die_on_bad_params => 0, loop_context_vars => 1);
	
	$qry = qq{
		select distinct
			cities.cities_id,
			cities.city
		from
			trainstations,
			cities
		where
			trainstations.cities_id > 0 and
			trainstations.cities_id = cities.cities_id
		order by
			2
	};
	
	$sth = $dbh->prepare($qry);
	$sth->execute;
	
	my @stations;
	while (my $data = $sth->fetchrow_hashref("NAME_lc")) {
	
		push @stations, {
			STATIONCODE => $data->{cities_id},
			STATIONNAME => $data->{city},
		};
	}
	
	my $inittrn = $routes[0]->{shortname};
	
	my @initstops = map{{
		STOPNAME => $_->stopname,
		STOPARR => $_->arrival,
		STOPDEP => $_->departure,
		STOPNUM => $_->stopnum,
		STOPDAYNUM => $_->daynum,
		STOPDISTANCE => $_->distance
	}} RailDB::Schedule->retrieve_from_sql(qq{shortname = '$inittrn' order by stopnum});

	$qry = qq{select city from cities where cities_id = ?};
	$sth = $dbh->prepare($qry);
	$sth->execute($src);
	
	my $data = $sth->fetchrow_arrayref();
	my $srccity = $data->[0];
	
	$sth->execute($dest);
	$data = $sth->fetchrow_arrayref();
	my $destcity = $data->[0];
	
	my $runson = $inittrn ? get_days(RailDB::Trains->retrieve(shortname => $inittrn)->runson) : undef;
		
	$tpl->param(
		SOURCE => $srccity,		
		DESTINATION => $destcity,
		TRAINNAME => $routes[0]->{longname},
		TRAINCODE => $inittrn,
		STATIONS => \@stations,
		ROUTES => \@routes,
		RUNSON => $runson, 
		STOPS => \@initstops,
	);
	
	return $tpl->output;
}

sub getschedule {

	my $app = shift;
	my $shortname = $app->query->param('shortname');
	
	my @stops = map{{
		STOPNAME => $_->stopname,
		STOPARR => $_->arrival,
		STOPDEP => $_->departure,
		STOPNUM => $_->stopnum,
		STOPDAYNUM => $_->daynum,
		STOPDISTANCE => $_->distance
	}} RailDB::Schedule->retrieve_from_sql(qq{shortname = '$shortname' order by stopnum});
	
	my $train = RailDB::Trains->retrieve(shortname => $shortname);
	my $longname = $train->longname;
	my $runson = $train->runson;
	
	my $tpl = $app->load_tmpl('railschedule.tpl', die_on_bad_params => 0, loop_context_vars => 1);

	$tpl->param(
		TRAINNAME => $longname,
		TRAINCODE => $shortname,
		RUNSON => get_days($runson),
		STOPS => \@stops,
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
