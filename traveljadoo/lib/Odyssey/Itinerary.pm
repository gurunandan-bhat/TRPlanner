package Odyssey::Itinerary;

use strict;
use warnings;

use lib qw{../};

use base qw(Odyssey);

use CGI::Application::Plugin::Redirect;

use Odyssey::Hotels;

use OdysseyDB::City;
use OdysseyDB::Service;
use OdysseyDB::Hotel;
use OdysseyDB::QuotationCity;
use OdysseyDB::QuotationAccommodation;
use OdysseyDB::QuotationTicket;	
use OdysseyDB::WebText;

use Data::Dumper;
use Date::Manip;

use MIME::Lite;

our $VERSION = '0.01';

# Preloaded methods go here.

sub setup {
	my $app = shift;
	
	$app->mode_param('mode');

	$app->run_modes(
		move_on => 'move_on',
		move_to => 'move_to',
		inclist => 'inclist',
		testsp	=> '_raw_sp',
		transit => 'transit',
		randomcity => 'randomcity',
		otherroutes => 'otherroutes',
		end_tour => 'end_tour',
		getmapcities => 'getmapcities',
		getmappath => 'getmappath',
		send_email => 'send_email',
		login => 'login',
		logout => 'logout',
	);

	$app->authen->protected_runmodes(':all');
		
	$app->start_mode('move_on');
	$app->error_mode('errhndlr');
}


sub move_on {

	my $app = shift;

	my $tpl = $app->load_tmpl('new_move_on.tpl', die_on_bad_params => 0, global_vars => 1);

	# Pick up default city from the session or from the conf file if not explicitly passed
	my $destid = $app->query->param('destid') || $app->config_param('default.StartingCity');
	my $dest = OdysseyDB::City->retrieve($destid);
	
	$tpl->param(
		NUMIMAGES => $app->cityimages($destid),
		CURRNAME => $dest->city,
		CURRONELINER => $dest->oneliner,
		CURRWRITEUP => addptags($dest->writeup),
		CURRID => $destid,
		LASTHOTELID => $app->get_last_hotel(),
		LATITUDE => $dest->latitude,
		LONGITUDE => $dest->longitude,
	);

	my @nrcities = map {{
		ID => $_->cities_id,
		NAME => $_->city,
		ONELINER => $_->oneliner,
		WRITEUP => firstpara($_->writeup),
	}} $dest->nearcities;


	$tpl->param(
		DEFAULTCITYID => $nrcities[0]->{ID},
		DEFAULTCITYNAME => $nrcities[0]->{NAME},
		DEFAULTCITYWRITEUP => $nrcities[0]->{WRITEUP},
	);
	
	$tpl->param(NEARCITIES => \@nrcities);


	my @randomdestination = map {{
		RANDOMDESTID => $_->cities_id,
		RANDOMDESTNAME => $_->city,
	}} OdysseyDB::City->search_randomcities;
	$tpl->param(RANDOMDESTINATION => \@randomdestination);	
	
	if (my $summary = $app->tour_summary) {
		$tpl->param(
			SMALLSUMMARY => $summary->{smalltable},
			SUMMARY => $summary->{table},
			PAXNAME => $summary->{paxname},
			DEPCITYNAME => $summary->{depcityname},
			DEPDATE => $summary->{depdate},
			DEPDAYNUM => $summary->{depdaynum},
		);
	}
	return $tpl->output;
}

sub move_to {
	my $app = shift;

	my $destid = $app->query->param('destid');
	my $srcid = $app->query->param('srcid');

	my $tonotset =  'Have you entered your destination city? 
		Check the URL and ensure that the city=some value.
		 If you want to check out this city, I must know 
		 where you want to go';
	die({type => 'notice', msg => $tonotset}) unless $destid;
	 
	my $fromnotset = 'Have you entered the "from" city? 
		Check the URL and ensure that the from=some value.
		 If you want to check out this city, I must know 
		 where you came from';
	die({type => 'notice', msg => $fromnotset}) unless $srcid;
	
	my $ttype = $app->query->param('type') || 'new';

	my $tpl = $app->load_tmpl('new_move_to.tpl', die_on_bad_params => 0, global_vars => 1, loop_context_vars => 1,);
	
	die({type => 'notice', msg => 'No Data available in our Database about the city where you are coming from'})
		unless (my $src = OdysseyDB::City->retrieve($srcid));
	
	die({type => 'notice', msg => 'No Data available in our Database about the city you want to go to'})
		unless (my $dest = OdysseyDB::City->retrieve($destid));	

	# Start getting display stuff.

	$tpl->param(
		FROMNAME => $src->city,
		FROMID => $srcid,
	);
	
	my @nrcities;
	for ( $src->nearcities ) {

		next if ($_->cities_id == $destid);
		
		push(@nrcities, {
			PREID => $_->cities_id,
			PRENAME => $_->city,
		});
	}
	$tpl->param(NEARCITIES => \@nrcities);

	my $link = $app->query->url(-path_info => 1, -query => 1);

	$tpl->param(
		NUMIMAGES => $app->cityimages($destid),
		CURRID => $destid,
		CURRNAME => $dest->city,
		CURRONELINER => $dest->oneliner,
		CURRWRITEUP => addptags($dest->writeup),
		CURRWEBWRITEUP => addptags($dest->webwriteup),
		CURRDEFDAYS => (my $defaultdays = $dest->defaultdays),
		LATITUDE => $dest->latitude,
		LONGITUDE => $dest->longitude,
		OLDLINK => ($link =~ /type\=/) ? $link : $link . '&type=old',
	);

	my @daysloop;
	for (1..6) {
		my $dayselected = ($defaultdays == $_) ? 1 : 0;
		push(@daysloop, {
			DAYVALUE => $_, 
			DAYSELECTED => $dayselected
		});
	}
	$tpl->param(DAYSLOOP => \@daysloop);	

	my $defhotelcategory = $app->session->param('mystatus')->{defaulthotelcategory} || 0;
	
	my @defaulthotels = OdysseyDB::Hotel->search_defaulthotels($destid);
	
	my $defaulthotel = $defaulthotels[0];
	foreach (@defaulthotels) {
		last if ($_->costcategoryid > $defhotelcategory);
		$defaulthotel = $_;
	}

	$tpl->param(
		DEFAULTHOTELID => $defaulthotel->addressbook_id,
		DEFAULTHOTELNAME => $defaulthotel->organisation,
		DEFAULTHOTELDESCRIPTIONSMALL => firstpara($defaulthotel->description),
		DEFAULTHOTELDESCRIPTION => $defaulthotel->description,
		DEFAULTHOTELCOSTCATEGORY => $defaulthotel->costcategory,
	);
	
############################################################ New
	my @otherhotels;
	foreach (@{OdysseyDB::Hotel->webhotels_bycity($destid)}) {
		next if ($_->{hotelid} == $defaulthotel->addressbook_id);
		$_->{hoteldescription} = firstpara($_->{hoteldescription});
		push @otherhotels, $_;
	}

#	my @tmp = OdysseyDB::Hotel->search_alltypes_bycity($destid);
#	return '<pre>' . Dumper(\@tmp) . '</pre>';
	
#	foreach (OdysseyDB::Hotel->search_alltypes_bycity($destid)) {
#		next if ($_->addressbook_id == $defaulthotel);
#		push @otherhotels, {
#			HOTELID => $_->addressbook_id,
#			HOTELNAME => $_->organisation,
#			HOTELDESCRIPTIONSMALL => firstpara($_->description),
#			HOTELCOSTCATEGORY => $_->costcategory(),
#		};
#	}
	
############################################################ End New

	
	$tpl->param(OTHERHOTELS => \@otherhotels);				
	
	$tpl->param(STARTINGPOINT => 1) if ($srcid == $destid);

	if (my @randomcities = OdysseyDB::City->search_randomcities) {
		my @randomdestination;
		for (@randomcities) {
			push @randomdestination, {
				RANDOMDESTID => $_->cities_id,
				RANDOMDESTNAME => $_->city,
			};
		}
		$tpl->param(RANDOMDESTINATION => \@randomdestination);	
	}

	# We have most of the display stuff in. Calculate Route Options.
	# _get_routes calculates travel options, stores in session and
	# prepares travel options as a radio-button form fragment from
	# a template (options_table.tpl). See _get_routes for explanation
	# of why travel options are read from a session and not the form
 
	my $depdatetime = $app->session->param('mystatus')  ? 
		$app->session->param('mystatus')->{dateout} . ' 09:00' : '12/31/2008 09:00';

	$tpl->param(ROUTEOPTIONS => $app->_get_routes($srcid, $destid, $depdatetime));

	# This generates the tour summary for display inherited from Odyssey.pm
	
	if (my $summary = $app->tour_summary) {
		$tpl->param(
			SUMMARY => $summary->{table},
			PAXNAME => $summary->{paxname},
			DEPCITYNAME => $summary->{depcityname},
			DEPDATE => $summary->{depdate},
			DEPDAYNUM => $summary->{depdaynum},
		);
	}
	
	return $tpl->output;	
}

sub transit {

	# When you come here - the following variables are available
	# as a part of the session variable mystatus:
	# quotation id and departure date from this city. 

	# The following variables are available in the form post:
	# next destination city, how many days you plan to stay there
	# how will you travel from the last confirmed city  to the next 
	# destination and which hotel you will stay in.

	# This function does three things: Updates the database and the
	# session object mystatus
	 
	my $app = shift;
	
	# Read posted parameters 	
	my $cityid = $app->query->param('city');
	my $days = $app->query->param('days'); # actually means nights
	my $hotelid = $app->query->param('hotel');
	my $travelopts = $app->query->param('travelopts');

	# Get arrivaldate of last leg of (possibly) multiple hop route selected 	
	my @optionlist = @{$app->session->param('optionlist')};
	my @selectedoption;
	for (@optionlist) {
		next if ($_->{optionno} != $travelopts);
		push @selectedoption, $_;
	}
	my $arrival = $selectedoption[-1]->{arrival};

	# Arrival and Departure dates in DD/MM/YYYY
	my $datein = UnixDate($arrival, '%m/%d/%Y');
	my $dateout = UnixDate(DateCalc($arrival, "+ $days days"), '%m/%d/%Y');
	
	my $mystatus = $app->session->param('mystatus');
	
	# TODO One day, MS-SQL Auto-ids will be used and make me transaction-safe. 
	# Insert into QuoCities
	my $quocitiesid = OdysseyDB::QuotationCity->maximum_value_of('quocities_id') + 1;
	OdysseyDB::QuotationCity->insert({
		quocities_id => $quocitiesid,
		quotations_id => $mystatus->{quotationid},
		datein => $datein,
		dateout => $dateout,
		tocities_id => $cityid, 
	});

	# Insert into QuoAccommodation
	my $quoaccommodationid = OdysseyDB::QuotationAccommodation->maximum_value_of('quoaccommodation_id') + 1;
	OdysseyDB::QuotationAccommodation->insert({
		quoaccommodation_id => $quoaccommodationid,
		hoteladdressbook_id => $hotelid,
		quocities_id => $quocitiesid,
		nights => $days,
		quotations_id => $mystatus->{quotationid},
	});
	
	# Insert into QuoTickets
	my $quoticketsid = OdysseyDB::QuotationTicket->maximum_value_of('quotickets_id') + 1;
	for (@selectedoption) {

		last if ($_->{fromcities_id} == $_->{tocities_id});

		OdysseyDB::QuotationTicket->insert({
			tickets_id => _fix_mode($_->{mode}),
			quotickets_id => $quoticketsid,
			quocities_id => $quocitiesid,
			from_cities_id => $_->{fromcities_id},
			to_cities_id => $_->{tocities_id},
			trainno => $_->{trainno},
			flightno => $_->{modeno},
			etd => $_->{departure},
			eta => $_->{arrival},
			quotations_id => $mystatus->{quotationid},
		});

		++$quoticketsid;
	}

	# update session	
	$mystatus->{dateout} = $dateout;
	$app->session->param(mystatus => $mystatus);
	
	# redirect to "Moving On" page
	$app->redirect("travel.cgi?mode=move_on&destid=$cityid");
}

sub otherroutes {

	my $app = shift;
	
	my $departure = $app->query->param('departure');
	my $from = $app->query->param('from');
	my $to = $app->query->param('to');
	my $hops = $app->query->param('hops');
	my $modepref = $app->query->param('modepref');
	
	my $dbh = OdysseyDB::City->db_Main();
	my $sth = $dbh->prepare("exec p_RouteFinder_x $departure, $from, $to, 3, 2, $modepref");
	$sth->execute;
	
	my @optionlist;
	my $travelopts = [[]];
	my $modeopts = [[]];
	my $parent_idx = -1;
	my $child_idx = 0;
	my $last_option = 0;

	my $optionnumber =  @{ $app->session->param('optionlist') };
		
	while (my $res = $sth->fetchrow_hashref) {

		if ( $res->{optionno} == $last_option ) {
			++$child_idx;
		}
		else {
			++$parent_idx;
			++$optionnumber;
			$child_idx = 0;
		}

		push @optionlist, { # Only optionno is posted via form. Other option details are saved in session
			optionno => $optionnumber,
			fromcities_id => $res->{fromcities_id},
			tocities_id => $res->{tocities_id},
			mode => $res->{mode},
			modeno => $res->{modeno},
			trainno => $res->{trainno},
			departure => $res->{departure},
			arrival => $res->{arrival},
		};

		$modeopts->[$parent_idx][$child_idx] = $res->{modestr};

		$travelopts->[$parent_idx][$child_idx] = { # For Display purposes only!
			opt_method =>  $res->{modeno},
			opt_number => $optionnumber,
			opt_source => $res->{fromcity}, 
			opt_departure => UnixDate($res->{departure}, "%e %b %H:%M"), 
			opt_destination => $res->{tocity}, 
			opt_arrival => UnixDate($res->{arrival}, "%e %b %H:%M"),
		};
		
		$last_option = $res->{optionno};
	}

	return '<p class="notice">Sorry! There are no alternatives to this route. Consider tweaking other routes</p>' unless (@optionlist);

	my @otherroutes;
	my $i = 0;
	for (@{ $modeopts }) {
		push @otherroutes, {
			OPTIONNUMBER => $travelopts->[$i]->[0]->{opt_number},
			OPTIONHEADER => join(', ', @{$_}),
			OPTIONHOPS => $travelopts->[$i],
		};
		++$i;
	}
	
	# Push updated Route options into session
	my $tmpoptlist = $app->session->param('optionlist');
	push @{ $tmpoptlist }, @optionlist;
	$app->session->param(optionlist => $tmpoptlist);
	
	my $tpl = $app->load_tmpl('otherroutes.tpl', die_on_bad_params => 0, global_vars => 1, );
	$tpl->param(OTHERROUTES => \@otherroutes);
	
	return $tpl->output;
}

sub end_tour {
	my $app = shift;

	my $quotationid = $app->session->param('mystatus')->{quotationid};

	$app->redirect('index.cgi?mode=restart') unless $quotationid;

	my $dbh = OdysseyDB::City->db_Main();
	my $testh = $dbh->prepare("exec p_AutoCompleteData $quotationid");
	$testh->execute;

	$testh = $dbh->prepare("exec p_AutoExecuteAll $quotationid");
	$testh->execute;

	my @cityerrors;
	my @quocities = OdysseyDB::Quotation->retrieve(quotations_id => $quotationid)->quocities;
	foreach my $quocity (@quocities) {
		if ($quocity->warndesc) {
			push @cityerrors, {
				CITYID => $quocity->tocities_id,
				CITYNAME => OdysseyDB::City->retrieve(cities_id => $quocity->tocities_id)->city,
				ERRORTYPE => 'Warning',
				ERRORSTR => $quocity->warndesc,
			};
		}
		my @params = qw(accommodation tickets sightseeing transfers);
		foreach (@params) {
			my $field = 'quo' . $_ . 'ok';
			if (! $quocity->$field) {
				$testh = $dbh->prepare('exec p_quocheckintegrity' . $_ . " $quotationid");
				$testh->execute;
				push @cityerrors, {
					CITYID => $quocity->tocities_id,
					CITYNAME => OdysseyDB::City->retrieve(cities_id => $quocity->tocities_id)->city,
					ERRORTYPE => uc($_),
					ERRORSTR => $quocity->errordesc,
				};
			}
		}	
	}
	my $tpl = $app->load_tmpl('itinerary_errors.tpl', die_on_bad_params => 0);

	if (@cityerrors) {
		$tpl->param(CITYERRORS => \@cityerrors);
	}

	$testh = $dbh->prepare("exec p_AutoExecuteQuoLines $quotationid");
	$testh->execute;


	$testh = $dbh->prepare("exec p_RptQuoItinerary $quotationid, 1");
	$testh->execute;

	my @itinerary;
	while (my $row = $testh->fetchrow_hashref("NAME_lc")) {
		push @itinerary, {
			DAYNUM => $row->{dayno},
			DATE => UnixDate($row->{datein}, "%a, %d %b %y"),
			CITY => $row->{city},
			DETAIL => $row->{remarks},
		};
	}
	$tpl->param(SUMMARY => \@itinerary);

	$app->session->param('emailsummary', \@itinerary);

#	$testh = $dbh->prepare("exec p_Rpt_DetailedItinerary $quotationid, 1");
#	$testh->execute;
#
#	my @report;
#	while (my $row = $testh->fetchrow_hashref("NAME_lc")) {
#		push @report, {
#			DATE => UnixDate($row->{quodate}, "%e %b %Y"),
#			CITY => $row->{city},
#			DAYNUM => $row->{dayno},
#			HEADER => $row->{dettypestring},
#			DETAIL => addptags($row->{detstring}),
#		};
#	}
#	$tpl->param(DETAILS => \@report);

	$tpl->param(
		TITLE => OdysseyDB::WebText->retrieve(web_id => 37)->title,
		TEXT1 => addptags(OdysseyDB::WebText->retrieve(web_id => 37)->writeup),
		TEXT2 => addptags(OdysseyDB::WebText->retrieve(web_id => 38)->writeup),
		TEXT3 => addptags(OdysseyDB::WebText->retrieve(web_id => 39)->writeup),
	);

	return $tpl->output;
}

sub send_email {
	
	my $app = shift;
	my $sqrequest = $app->query->param('sqrequest') || 'No Special Request';
	my $emailsummary = $app->session->param('emailsummary');
	my $quotationid = $app->session->param('mystatus')->{quotationid};
	my $paxname = OdysseyDB::Quotation->retrieve($quotationid)->paxname;

	my $msg = MIME::Lite->new(
		To => $app->authen->username,
		CC => 'hans@odyssey.co.in',
		From => 'Travellers Palm Administrator <admin@odyssey.co.in>',
		Subject => 'Your Request for a Quote',
		Type => 'multipart/related',
	);

	my $mailtpl = $app->load_tmpl('email.tpl', die_on_bad_params => 0);
	$mailtpl->param(
		PAXNAME => $paxname,
		PAXEMAIL => $app->authen->username,
		SUMMARY => $emailsummary,
		SQREQUEST => $sqrequest,
		QUOTEID => $quotationid,
	);
	
	$msg->attach(
		Type => 'text/html',
		Data => $mailtpl->output,
	);

	MIME::Lite->send(
		'smtp', 
		'traveljadoo.com', 
		Timeout => 30,
		AuthUser => 'webmaster@travellers-palm.com',
		AuthPass => 'ip31415',
		Debug => 1,
	);
	
	$msg->send;
	
	my $tpl = $app->load_tmpl('quote_thanks.tpl', die_on_bad_params => 0);
	return $tpl->output;
}

sub _fix_mode {
	my $mode = shift;
	return 5 if ($mode == 1);
	return 1 if ($mode == 2);
	return 2 if ($mode == 3);
	return $mode;
}

sub randomcity {
	my $app = shift;
	my $redirecturl = $app->query->param('desturl');
	$app->redirect($redirecturl);
}

sub addptags {

	return '<p class="writeup"></p>' unless (my $str = shift);

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

sub inclist {
	# test routine
	
	my $app = shift;
	
	
	my $str = "\%ENV: \n";
	for (keys %ENV) {
		$str .= $_ . ' => ' . $ENV{$_} . "\n";
	}
	
	$str .= "\n\%INC: \n";
	for (keys %INC) {
		$str .= $_ . ' => ' . $INC{$_} . "\n";
	}
	
	$str .= "\n\@INC: \n";
	for (@INC) {
		$str .= $_ . "\n";
	}	
	
	$app->header_add(-type => 'text/plain');
	return "$str";
}


sub _format_tstamps {
	my $dep = shift;
	my $arr = shift;
	
	my $err;
	return (
		UnixDate($dep, "%e %b %H:%M"), 
		UnixDate($arr, "%e %b %H:%M"),
	);
}

sub firstpara {
	my $str = shift;
	$str = addptags($str);
	$str =~ /^\<p class=\"writeup\"\>(.*?)\<\/p\>/;
	return $1;
}

1;
