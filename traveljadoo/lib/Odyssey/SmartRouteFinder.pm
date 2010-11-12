package Odyssey::SmartRouteFinder;

use strict;
use warnings;

use lib qw{../};

use base qw(Odyssey);

use OdysseyDB::City;
use OdysseyDB::WebText;

use Date::Manip;
use Date::Calc qw(Delta_Days);

our $VERSION = '0.01';

# Preloaded methods go here.

sub setup {
	my $app = shift;
	
	$app->mode_param('mode');

	$app->run_modes(
		getroutes => 'getroutes',
	);

	$app->start_mode('getroutes');
	$app->error_mode('errhndlr');
	
}

sub getroutes {
	
	my $app = shift;
	
	my $arrdate = $app->query->param('arrdate');
	my $trhh = $app->query->param('trhh') || '08';
	my $trmm = $app->query->param('trmm') || '00';
	my $src = $app->query->param('src');
	my $dest = $app->query->param('dest');
	my $submit = $app->query->param('submit');
	 
	my $tpl = $app->load_tmpl('smartroutefinder.tpl', die_on_bad_params => 0);
	
	my (@fromcities, @tocities);
	foreach (OdysseyDB::City->search_webhotelcities) {

		my $cityid = $_->cities_id;
		my $city = $_->city;
		
		push @fromcities, {
			CITYID => $cityid,
			CITY => $city,
			SELECTED => $submit ? ( ($src == $cityid) ? 1 : undef ) : undef,
		};
		
		push @tocities, {
			CITYID => $cityid,
			CITY => $city,
			SELECTED => $submit ? ( ($dest == $cityid) ? 1 : undef ) : undef,
		};
	}

	$tpl->param(
		TRDATE => $arrdate,
		TRHH => $trhh,
		TRMM => $trmm,
		FROMCITIES => \@fromcities,
		TOCITIES => \@tocities,
		TITLE => OdysseyDB::WebText->retrieve(web_id => 52)->title,
		TEXT => addptags(OdysseyDB::WebText->retrieve(web_id => 52)->writeup),
	);
	
	return $tpl->output unless $submit;	
	
	my $dbh = OdysseyDB::City->db_Main();
	$dbh->{FetchHashKeyName} = 'NAME_lc';

	my $depdate = $dbh->quote(UnixDate("$arrdate $trhh:$trmm", "%m/%d/%Y %H:%M" ));
	my $rsth = $dbh->prepare("exec p_RouteFinder_x $depdate, $src, $dest, 3, 1, null");
	$rsth->execute;
	
	my $travelopts = [[]];
	my $modeopts =[[]];
	my $parent_idx = -1;
	my $child_idx = 0;
	my $last_option = 0;

	while (my $res = $rsth->fetchrow_hashref) {

		if ( $res->{optionno} == $last_option ) {
			++$child_idx;
		}
		else {
			++$parent_idx;
			$child_idx = 0;
		}

		$modeopts->[$parent_idx][$child_idx] = $res->{modestr};
		$travelopts->[$parent_idx][$child_idx] = { # For Display purposes only!
			opt_method => $res->{modestr} . ': ' . $res->{modeno},
			opt_source => $res->{fromcity}, 
			opt_departure => UnixDate($res->{departure}, "%e %b %H:%M"), 
			opt_destination => $res->{tocity}, 
			opt_arrival => UnixDate($res->{arrival}, "%e %b %H:%M"),
		};
		
		$last_option = $res->{optionno};
	}
	
	my $optpl = $app->load_tmpl('srf_options_table.tpl', die_on_bad_params => 0, global_vars => 1,);
	
	$optpl->param(
		FROMCITY => $travelopts->[0][0]->{opt_source},
		TOCITY => $travelopts->[0][-1]->{opt_destination},
	);
	
	
	my $modedesc = join(' and ', @{ $modeopts->[0] }); 
	$optpl->param(
		HDR1 => $modedesc,
		OPT1 => $travelopts->[0],
	);
	
	if ( $modeopts->[1] ) {
		$modedesc = join(' and ', @{ $modeopts->[1] }); 
		$optpl->param(
			HDR2 => $modedesc,
			OPT2 => $travelopts->[1],
		);
	}
	
	if ( $modeopts->[2] ) {
		$modedesc = join(' and ', @{ $modeopts->[2] }); 
		$optpl->param(
			HDR3 => $modedesc,
			OPT3 => $travelopts->[2],
		);
	}

	$tpl->param(OPTIONS => $optpl->output);
	return $tpl->output;
}

sub addptags {

	return '' unless (my $str = shift);

	my @lines = split m{
						(?:					# make capturing if saving terminators 
								\x0D \x0A	# CRLF         
							|   \x0A		# LF 
							|   \x0D		# CR 
							|   \x0C		# FF 
							|   \x{2028}	# Unicode LS 
							|   \x{2029}	# Unicode PS 
						)
					}x, $str;
					
	return '<p class="writeup">' . join('</p><p class="writeup">', @lines) . '</p>';
}

1;
