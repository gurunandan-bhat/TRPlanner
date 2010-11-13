package Odyssey::Hotels;

use strict;
use warnings;

use lib qw{../};

use base qw(Odyssey);

use OdysseyDB::City;
use OdysseyDB::State;
use OdysseyDB::Hotel;
use OdysseyDB::HotelCategory;
use OdysseyDB::WebPage;
use OdysseyDB::WebText;
use OdysseyDB::Image;

use Date::Manip;
use JSON;

use Data::Dumper;

our $VERSION = '0.01';

# Preloaded methods go here.

sub setup {
	my $app = shift;
	
	$app->mode_param('mode');

	$app->run_modes(
		main	=>	'main',
		index => 'index',
		why => 'why',
		describe => 'describe',
		minidescribe => 'minidescribe',
		search	=> 'search',
		hoteltypes => 'hoteltypes',
		minihoteltypes => 'minihoteltypes',
		namesearch => 'namesearch',
		cityhotels => 'cityhotels',
	    statehotels => 'statehotels',
	    heritagehotels => 'heritagehotels',
	    homestays => 'homestays',
	    hotelstates => 'hotelstates',
	    showdetails => 'showdetails',
	    login => 'login',
	    logout => 'logout',
		save_favourites => 'save_favourites',
		protected_save_favourites => 'protected_save_favourites',
		favourites => 'favourites',
		testtop => 'testtop',
		getimg_attr => 'getimg_attr',
	);

	$app->start_mode('index');
	$app->error_mode('errhndlr');
}

sub index {
	
	my $app = shift;
	my $tpl = $app->load_tmpl('new_specialplaces.tpl', die_on_bad_params => 0,);

	my @states;
	foreach (OdysseyDB::State->search_webhotelstates) {
		push @states, {
			STATEID => $_->states_id,
			STATE => $_->state,
			STATEURL => $_->url,
			STATEONELINER => $_->oneliner,
			STATEWRITEUP => firstpara($_->writeup),
		};
	}
	
	my @cities;
	foreach (OdysseyDB::City->search_webhotelcities) {
		push @cities, {
			CITYID => $_->cities_id,
			CITY => $_->city,
			CITYURL => $_->url,
		};
	}
	
	my $webpage = OdysseyDB::WebPage->retrieve(webpages_id => 20);
	my $sidetext = OdysseyDB::WebText->retrieve(web_id => 11);

	my @fairs;
	foreach (74..84) {
		my $fair = OdysseyDB::WebText->retrieve(web_id => $_);
		push @fairs, {
			FAIRID => $_,
			FAIRNAME => $fair->title,
			FAIRDESC => $fair->writeup,
		};
	}
	
	$tpl->param({
		METADESCRIPTION => $webpage->metatype,
		METAKEYWORDS => $webpage->keywords,
		PAGETITLE => $webpage->descr,
		SIDETITLE => $sidetext->title,
		SIDETEXT => addptags($sidetext->writeup),
		STATES => \@states,
		CITIES => \@cities,
		FAIRS => \@fairs,
		TEXT => boldify(addptags(OdysseyDB::WebText->retrieve(web_id => 32)->writeup)),
	});

	return $tpl->output;
}

sub showdetails {
	
	my $app= shift;
	my $stateid = $app->query->param('stateid');
	
	my $tpl = $app->load_tmpl('city_list.tpl', die_on_bad_params => 0);
	
	my @cities = map {{
		CITYID => $_->id,
		CITYNAME => $_->city,
	}} OdysseyDB::City->search_webhotelcities_bystate($stateid);
	
	$tpl->param(
		STATEID => $stateid,
		STATENAME => OdysseyDB::State->retrieve(states_id => $stateid)->state,
		CITIES => \@cities,
	);
	
	return $tpl->output;
}

sub main {
	
	my $app = shift;
	my $tpl = $app->load_tmpl('hotel_index.tpl');

	my @states;
	foreach (OdysseyDB::State->search_webhotelstates) {
		push @states, {
			STATEID => $_->states_id,
			STATE => $_->state,
		};
	}
	
	my @cities;
	foreach (OdysseyDB::City->search_webhotelcities) {
		push @cities, {
			CITYID => $_->cities_id,
			CITY => $_->city,
		};
	}
	
	$tpl->param({
		STATES => \@states,
		CITIES => \@cities,
	});

	return $tpl->output;
}

sub why {
	
	my $app = shift;
	my $tpl = $app->load_tmpl('hotel_why.tpl');

	my @states;
	foreach (OdysseyDB::State->search_webhotelstates) {
		push @states, {
			STATEID => $_->states_id,
			STATE => $_->state,
		};
	}
	
	my @cities;
	foreach (OdysseyDB::City->search_webhotelcities) {
		push @cities, {
			CITYID => $_->cities_id,
			CITY => $_->city,
		};
	}
	
	$tpl->param({
		STATES => \@states,
		CITIES => \@cities,
	});

	return $tpl->output;
}

sub search {

	my $app = shift;
	my $subject = $app->query->param('subject');

	my $id = $app->query->param('id');
	
	die({type => 'error', msg => 'Invalid State or City. Please enter a valid City or State'}) unless $id;

	if ($subject eq 'state') {

		my @cities = OdysseyDB::City->search_webhotelcities_bystate($id);
		my $cid = (@cities) ? $cities[0]->cities_id : 0;

		$app->redirect("hotel.cgi?mode=statehotels&sid=$id&cid=$cid&state=1");
	}
	elsif ($subject eq 'city') {
		
		my $sid = OdysseyDB::City->retrieve($id)->states_id;

		$app->redirect("hotel.cgi?mode=cityhotels&sid=$sid&cid=$id&city=1");
	}
}
	
sub namesearch {
	
	my $app = shift;
	my $name = '%' . uc($app->query->param('hotelname')) . '%';

	my @modhotels = map{ {
		HOTELID => $_->addressbook_id,
		HOTELNAME => $_->organisation,
		HOTELWRITEUP => firstpara($_->description),
		HOTELCITYNAME => OdysseyDB::City->retrieve(cities_id => $_->cities_id)->city,
		HOTELSTATENAME => OdysseyDB::State->retrieve(states_id => $_->states_id)->state,
		HOTELURL => $_->url,
	} } OdysseyDB::Hotel->search_hotelname($name);
	
	my @states;
	foreach (OdysseyDB::State->search_webhotelstates) {
		push @states, {
			STATEID => $_->states_id,
			STATE => $_->state,
			STATEURL => $_->url,
		};
	}
	
	my @cities;
	foreach (OdysseyDB::City->search_webhotelcities) {
		push @cities, {
			CITYID => $_->cities_id,
			CITY => $_->city,
			CITYURL => $_->url,
		};
	}

	my $tpl = $app->load_tmpl('hotel_search.tpl', die_on_bad_params => 0);

	$tpl->param(
		MODHOTELS => \@modhotels,
		STATES => \@states,
		CITIES => \@cities,
		SEARCH => 1,
		NORESULTS => ! @modhotels,
	);
	
	return $tpl->output;
}

sub cityhotels {
	
	my $app = shift;

#	return '<pre>|' . $app->session->param('username') . '|' . Dumper($app->session) . '</pre>';
		
	my $url = $app->param('city');
	my @scities = OdysseyDB::City->search(url => $url);
	my $city = $scities[0];
	
	my $cityid = $city->cities_id;
	my $state = $city->states_id;
	my $stateid = $state->states_id;
	my $stateurl = $state->url;
	
	my @modhotels;
	foreach (OdysseyDB::Hotel->search_moderate_bycity($cityid)) {
		push @modhotels, {
			HOTELID => $_->addressbook_id,
			HOTELNAME => $_->organisation,
			HOTELWRITEUP => firstpara($_->description),
			HOTELURL => $_->url,
		};
	}
	
	my @suphotels;
	foreach (OdysseyDB::Hotel->search_superior_bycity($cityid)) {
		push @suphotels, {
			HOTELID => $_->addressbook_id,
			HOTELNAME => $_->organisation,
			HOTELWRITEUP => firstpara($_->description),
			HOTELURL => $_->url,
		};
	}
	
	my @luxhotels;
	foreach (OdysseyDB::Hotel->search_luxury_bycity($cityid)) {
		push @luxhotels, {
			HOTELID => $_->addressbook_id,
			HOTELNAME => $_->organisation,
			HOTELWRITEUP => firstpara($_->description),
			HOTELURL => $_->url,
		};
	}

	my @tophotels;
	foreach (OdysseyDB::Hotel->search_topofline_bycity($cityid)) {
		push @tophotels, {
			HOTELID => $_->addressbook_id,
			HOTELNAME => $_->organisation,
			HOTELWRITEUP => firstpara($_->description),
			HOTELURL => $_->url,
		};
	}

	my @othercities;
	foreach (OdysseyDB::City->search_webhotelcities_bystate($stateid)) {

		my $id = $_->cities_id;
		next if ($cityid == $id);
		push @othercities, {
			OTHERCITYID => $id,
			OTHERCITYNAME => $_->city,
			OTHERSTATEID => $stateid,
			OTHERCITYURL => $_->url,
		};
	}

	my $showothercities = scalar(@othercities) - 1;
	
	my @states;
	foreach (OdysseyDB::State->search(countries_id => 200)) {
		push @states, {
			STATEID => $_->states_id,
			STATE => $_->state,
			STATEURL => $_->url,
		};
	}
	
	my @cities;
	foreach (OdysseyDB::City->search_webhotelcities) {
		push @cities, {
			CITYID => $_->cities_id,
			CITY => $_->city,
			CITYURL => $_->url,
		};
	}
	
	my $tpl = $app->load_tmpl('hotel_search.tpl', die_on_bad_params => 0);
	
	my (@relmods, @reltours);
	foreach ($city->itineraries) {
		
		next if $_->inactivewef;
		
		if ($_->readytours) {
			push @reltours, {
				ITIN_ID => $_->fixeditin_id,
				ITIN_TITLE => $_->title,
				ITIN_ADV => $_->adv,		
				ITIN_DURATION => $_->duration,
				ITIN_URL => $_->url,
			};
		}
		else {
			push @relmods, {
				ITIN_ID => $_->fixeditin_id,
				ITIN_TITLE => $_->title,
				ITIN_ADV => $_->adv,		
				ITIN_DURATION => $_->duration,
				ITIN_URL => $_->url,
			};
		}
	}

	my $username;
	my $isfav;
	if ($username = $app->session->param('username')) {

		my $sth = $app->dbh->prepare("select count(*) from favourites where username = '$username' and type = 'city' and id = $cityid");
		$sth->execute;

		($isfav) = $sth->fetchrow_array;
	}

	$tpl->param(
		METADESCRIPTION => $city->metatype || firstpara($city->writeup),
		METAKEYWORDS => $city->keywords || $city->city,
		PAGETITLE => $city->descr || undef,
		CITYNAME => $city->city,
		CITYID => $cityid,
		STATENAME => OdysseyDB::State->retrieve($stateid)->state,
		STATEID => $stateid,
		STATEURL => $stateurl,
		CITYONELINER => $city->oneliner,
		CITYWRITEUP => addptags($city->writeup),
		CITYWEBWRITEUP => addptags($city->webwriteup),
		OTHERCITIES => \@othercities,
		MODHOTELS => \@modhotels,
		SUPHOTELS => \@suphotels,
		LUXHOTELS =>\@luxhotels,
		TOPHOTELS =>\@tophotels,
		STATES => \@states,
		CITIES => \@cities,
		CITYTYPE => $app->param('city') ? 1 : 0,
		NUMIMAGES => $app->cityimages($cityid),
		RELMODS => \@relmods,
		RELTOURS => \@reltours,
		REGISTERED => $username ? 1 : 0,
		ISFAVOURITE => $isfav,
		ALTTITLE => OdysseyDB::WebText->retrieve(web_id => 2)->title,
		ADTITLE => OdysseyDB::WebText->retrieve(web_id => 34)->title,
		ALTTEXT => h4ify(OdysseyDB::WebText->retrieve(web_id => 2)->writeup),
		ADTEXT => h4ify(OdysseyDB::WebText->retrieve(web_id => 34)->writeup),
		MODTEXT => OdysseyDB::WebText->retrieve(web_id => 23)->writeup,
	);
	
	return $tpl->output;
	
}

sub statehotels {
	
	my $app = shift;
	
	my $url = $app->param('state');
	my @sstates = OdysseyDB::State->search(url => $url);
	my $state = $sstates[0];
	my $stateid = $state->states_id;
	
	my @othercities;
	foreach (OdysseyDB::City->search_webhotelcities_bystate($stateid)) {

		my $id = $_->cities_id;
		push @othercities, {
			OTHERCITYID => $id,
			OTHERCITYNAME => $_->city,
			OTHERSTATEID => $stateid,
			OTHERCITYURL => $_->url,
		};
	}

	my $showothercities = scalar(@othercities) - 1;
	
	my @states;
	foreach (OdysseyDB::State->search(countries_id => 200)) {
		push @states, {
			STATEID => $_->states_id,
			STATE => $_->state,
			STATEURL => $_->url,
		};
	}
	
	my @cities;
	foreach (OdysseyDB::City->search_webhotelcities) {
		push @cities, {
			CITYID => $_->cities_id,
			CITY => $_->city,
			CITYURL => $_->url,
		};
	}
	
	my $tpl = $app->load_tmpl('state_search.tpl', die_on_bad_params => 0);

	my (@relmods, @reltours);
	my %included;
	foreach my $city (OdysseyDB::City->search_webhotelcities_bystate($state->states_id)) {
		foreach my $itin ($city->itineraries) {
			next if $included{$itin->fixeditin_id};
			next if $itin->inactivewef;
			
			if ($itin->readytours) {
				push @reltours, {
					ITIN_ID => $itin->fixeditin_id,
					ITIN_TITLE => $itin->title,
					ITIN_ADV => $itin->adv,
					ITIN_DURATION => $itin->duration,
					ITIN_URL => $itin->url,
				};
			}
			else {
				push @relmods, {
					ITIN_ID => $itin->fixeditin_id,
					ITIN_TITLE => $itin->title,
					ITIN_ADV => $itin->adv,		
					ITIN_DURATION => $itin->duration,
					ITIN_URL => $itin->url,
				};
			}
			$included{$itin->fixeditin_id} = 1;
		}
	}
	

	my $imgname = lc($state->state);
	$imgname =~ s/\s+//g;
			
	$tpl->param(
		METADESCRIPTION => $state->metatype || firstpara($state->writeup),
		METAKEYWORDS => $state->keywords || $state->state,
		PAGETITLE => $state->descr || undef,
		STATENAME => $state->state,
		STATEID => $stateid,
		STATEONELINER => $state->oneliner,
		STATEWRITEUP => addptags($state->writeup),
		STATEWEBWRITEUP => addptags(linkify(boldify($state->webwriteup), $stateid)),
		OTHERCITIES => \@othercities,
		STATES => \@states,
		CITIES => \@cities,
		STATETYPE => $app->query->param('state') ? 1 : 0,
		CITYTYPE => $app->query->param('city') ? 1 : 0,
		STATEIMAGENAME => $imgname,
		LATITUDE => $state->latitude,
		LONGITUDE => $state->longitude,
		RELMODS => \@relmods,
		RELTOURS => \@reltours,
		ALTTITLE => OdysseyDB::WebText->retrieve(web_id => 2)->title,
		ADTITLE => OdysseyDB::WebText->retrieve(web_id => 34)->title,
		ALTTEXT => h4ify(OdysseyDB::WebText->retrieve(web_id => 2)->writeup),
		ADTEXT => h4ify(OdysseyDB::WebText->retrieve(web_id => 34)->writeup),
		MODTEXT => OdysseyDB::WebText->retrieve(web_id => 23)->writeup,
	);
	
	return $tpl->output;
	
}

sub describe {
	my $app = shift;
	my $url = $app->param('hotel');
	
	my @shotels = OdysseyDB::Hotel->search(url => $url);
	my $hotel = $shotels[0];
	my $hotelid = $hotel->addressbook_id;
	
	my $tpl = $app->load_tmpl('hotel.tpl', die_on_bad_params => 0);
	
	my $city = $hotel->cities_id;
	my $cityid = $city->cities_id;
	my $cityurl = $city->url;
	my $cityname = $city->city;

	my $state = $city->states_id;
	my $stateid = $state->states_id;
	my $statename = $state->state;
	my $stateurl = $state->url;
	
	if ($hotel) {
		my $currcity = OdysseyDB::City->retrieve(cities_id => $cityid);
		$tpl->param(
			METADESCRIPTION => $hotel->metatype || firstpara($hotel->description),
			METAKEYWORDS => $hotel->keywords || $hotel->organisation,
			PAGETITLE => $hotel->descr || undef,
			NUMIMAGES => $app->hotelimages($hotelid),
			HOTELID => $hotel->addressbook_id,
			HOTELNAME => $hotel->organisation,
			HOTELDESCRIPTION => addptags($hotel->description),
			HOTELDETAIL1 => addptags($hotel->webwriteup1),
			HOTELDETAIL2 => addptags($city->webwriteup),
			HOTELCITYNAME => $cityname,
			HOTELCITYURL => $cityurl,
			HOTELCITYDESCRIPTION => addptags($city->writeup),
			TARIFF => $app->gettariff($hotelid),
			LATITUDE => $currcity->latitude,
			LONGITUDE => $currcity->longitude,
		);
	}
	else {
		$tpl->param(HOTELNAME => 'No Hotel Found!')
	}

############################################## New
	my $hotelcategory;
	my @modhotels;
	foreach (OdysseyDB::Hotel->search_moderate_bycity($cityid)) {
		if ($_->addressbook_id == $hotelid) {
			$hotelcategory = '($)';
			next;
		}
		push @modhotels, {
			HOTELID => $_->addressbook_id,
			HOTELNAME => $_->organisation,
			HOTELURL => $_->url,
		};
	}
	
	my @suphotels;
	foreach (OdysseyDB::Hotel->search_superior_bycity($cityid)) {
		if ($_->addressbook_id == $hotelid) {
			$hotelcategory = '($$)';
			next;
		}
		push @suphotels, {
			HOTELID => $_->addressbook_id,
			HOTELNAME => $_->organisation,
			HOTELURL => $_->url,
		};
	}
	
	my @luxhotels;
	foreach (OdysseyDB::Hotel->search_luxury_bycity($cityid)) {
		if ($_->addressbook_id == $hotelid) {
			$hotelcategory = '($$$)';
			next;
		}
		push @luxhotels, {
			HOTELID => $_->addressbook_id,
			HOTELNAME => $_->organisation,
			HOTELURL => $_->url,
		};
	}

	my @tophotels;
	foreach (OdysseyDB::Hotel->search_topofline_bycity($cityid)) {
		if ($_->addressbook_id == $hotelid) {
			$hotelcategory = '($$$$)';
			next;
		}
		push @tophotels, {
			HOTELID => $_->addressbook_id,
			HOTELNAME => $_->organisation,
			HOTELURL => $_->url,
		};
	}
##############################################

	my @states;
	foreach (OdysseyDB::State->search_webhotelstates) {
		push @states, {
			STATEID => $_->states_id,
			STATE => $_->state,
			STATEURL => $_->url,
		};
	}
	
	my @cities;
	foreach (OdysseyDB::City->search_webhotelcities) {
		next if ($_->cities_id == $cityid);
		push @cities, {
			CITYID => $_->cities_id,
			CITY => $_->city,
			CITYURL => $_->url,
		};
	}

	my $username;
	my $isfav;
	if ($username = $app->session->param('username')) {
		my $sth = $app->dbh->prepare("select count(*) from favourites where username = '$username' and type = 'hotel' and id = $hotelid");
		$sth->execute;
		($isfav) = $sth->fetchrow_array;
	}

	my (@relmods, @reltours);
	foreach ($city->itineraries) {
		next if $_->inactivewef;
		if ($_->readytours) {
			push @reltours, {
				ITIN_ID => $_->fixeditin_id,
				ITIN_TITLE => $_->title,
				ITIN_ADV => $_->adv,		
				ITIN_DURATION => $_->duration,
				ITIN_URL => $_->url,
			};
		}
		else {
			push @relmods, {
				ITIN_ID => $_->fixeditin_id,
				ITIN_TITLE => $_->title,
				ITIN_ADV => $_->adv,		
				ITIN_DURATION => $_->duration,
				ITIN_URL => $_->url,
			};
		}
	}

	$tpl->param(
		HOTELCATEGORY => $hotelcategory,
		OTHERHOTELS => scalar(@modhotels || @suphotels || @luxhotels) || 0,
		MODHOTELS => \@modhotels || undef,
		SUPHOTELS => \@suphotels || undef,
		LUXHOTELS => \@luxhotels || undef,
		TOPHOTELS => \@tophotels || undef,
		STATES => \@states,
		THISSTATEID => $stateid,
		THISSTATENAME => $statename,
		THISSTATEURL => $stateurl,
		CITIES => \@cities,
		RELMODS => \@relmods || undef,
		RELTOURS => \@reltours || undef,
		SHOWSTATELINK => ($cityname eq $statename) ? undef : 1,
		REGISTERED => $username ? 1 : 0,
		ISFAVOURITE => $isfav,
		ALTTITLE => OdysseyDB::WebText->retrieve(web_id => 2)->title,
		ADTITLE => OdysseyDB::WebText->retrieve(web_id => 34)->title,
		ALTTEXT => h4ify(OdysseyDB::WebText->retrieve(web_id => 2)->writeup),
		ADTEXT => h4ify(OdysseyDB::WebText->retrieve(web_id => 34)->writeup),
		HIDEMAP => @relmods || @reltours || 0,
	);
	
	return $tpl->output;
}

sub minidescribe {
	
	my $app = shift;
	my $hotelid = $app->query->param('id');
	
	my $hotel = OdysseyDB::Hotel->retrieve($hotelid);
	
	my $tpl = $app->load_tmpl('minihotel.tpl', die_on_bad_params => 0);
	$tpl->param(
		HOTELID => $hotelid,
		HOTELNAME => $hotel->organisation,
		NUMIMAGES => $app->hotelimages($hotelid),
		HOTELDESCRIPTION => addptags($hotel->description),
	);

	return $tpl->output; 
}

sub hotelstates {

	my $app = shift;

	my @states = map{{
		id => $_->states_id, 
		name => $_->state, 
		lat => $_->latitude, 
		lng => $_->longitude,
		desc => $_->oneliner,
	}} OdysseyDB::State->search_webhotelstates;

	return JSON->new->utf8(1)->encode(\@states);
}

sub hoteltypes {

	my $app = shift;
	my $tpl = $app->load_tmpl('hoteltypes.tpl', die_on_bad_params => 0);
	
	my $text = OdysseyDB::WebText->retrieve(web_id => 18);
	my $title = $text->title;
	my $writeup = $text->writeup;	
	
	my @states;
	foreach (OdysseyDB::State->search_webhotelstates) {
		push @states, {
			STATEID => $_->states_id,
			STATE => $_->state,
		};
	}
	
	my @cities;
	foreach (OdysseyDB::City->search_webhotelcities) {
		push @cities, {
			CITYID => $_->cities_id,
			CITY => $_->city,
		};
	}

	my $webpage = OdysseyDB::WebPage->retrieve(webpages_id => 7);

	$tpl->param(
		METADESCRIPTION => $webpage->metatype,
		METAKEYWORDS => $webpage->keywords,
		PAGETITLE => $webpage->descr,
		TITLE => $title,
		WRITEUP => boldify(addptags($writeup)),
		STATES => \@states,
		CITIES => \@cities,
	);
	
	return $tpl->output;
}

sub minihoteltypes {
	
	my $app = shift;
	my $tpl = $app->load_tmpl('minihoteltypes.tpl', die_on_bad_params => 0);
	
	my $text = OdysseyDB::WebText->retrieve(web_id => 18);
	my $title = $text->title;
	my $writeup = $text->writeup;	

	$tpl->param(
		TITLE => $title,
		WRITEUP => boldify(addptags($writeup)),
	);
	
	return $tpl->output;
}

sub heritagehotels {

	my $app = shift;
	
	my $tpl = $app->load_tmpl('heritagehotels.tpl', die_on_bad_params => 0);
	
	my $text = OdysseyDB::WebText->retrieve(web_id => 19);
	my $title = $text->title;
	my $writeup = $text->writeup;

	my @heritagehotels_in_state;
	foreach (OdysseyDB::State->search(countries_id => 200, {order_by => 'state'})) {
		my $sid = $_->states_id;
		
		my @heritagehotels = map {{
			ID => $_->addressbook_id,
			NAME => $_->organisation,
			DESC => firstpara($_->description),
			URL => $_->url,
		}} OdysseyDB::Hotel->search_heritagehotels_by_state($sid);
		
		push @heritagehotels_in_state, {
			STATENAME => $_->state,
			HOTELS => \@heritagehotels,
		};
	}
	
	my $webpage = OdysseyDB::WebPage->retrieve(webpages_id => 25);

	$tpl->param(
		METADESCRIPTION => $webpage->metatype,
		METAKEYWORDS => $webpage->keywords,
		PAGETITLE => $webpage->descr,
		TITLE => $title,
		WRITEUP => boldify(addptags($writeup)),
		HERITAGEHOTELS => \@heritagehotels_in_state,
	);
	
	return $tpl->output;
#	return '<pre>' . Dumper(\@heritagehotels_in_state) . '</pre>';	
}

sub homestays {

	my $app = shift;
	
	my $tpl = $app->load_tmpl('homestays.tpl', die_on_bad_params => 0);
	
	my $text = OdysseyDB::WebText->retrieve(web_id => 20);
	my $title = $text->title;
	my $writeup = $text->writeup;

	my @homestays_in_state;
	foreach (OdysseyDB::State->search(countries_id => 200, {order_by => 'state'})) {
		
		my $sid = $_->states_id;
		
		my @homestays = map {{
			ID => $_->addressbook_id,
			NAME => $_->organisation,
			DESC => firstpara($_->description),
			URL => $_->url,
		}} OdysseyDB::Hotel->search_homestays_by_state($sid);

		push @homestays_in_state, {
			STATENAME => $_->state,
			HOTELS => \@homestays,
		};
	}

	my $webpage = OdysseyDB::WebPage->retrieve(webpages_id => 25);

	$tpl->param(
		METADESCRIPTION => $webpage->metatype,
		METAKEYWORDS => $webpage->keywords,
		PAGETITLE => $webpage->descr,
		TITLE => $title,
		WRITEUP => boldify(addptags($writeup)),
		HOMESTAYS => \@homestays_in_state,
	);
	
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

sub gettariff {

	my $app = shift;
	my $hotelid = shift;
	my $fromdt = '01/01/2009';
	my ($day, $month, $year) = (localtime)[3..5];
	my $asofdt = sprintf("%02d/%02d/%04d", $month+1, $day, $year+1900);

	my $dbh = OdysseyDB::Hotel->db_Main();
	$dbh->syb_date_fmt('ISO');

	my @tariff;
	my $testh = $dbh->prepare("Exec p_HotelPriceList '10/01/2008', '', '', 1, 27, 1, 2, 0, $hotelid, '$asofdt'");
	$testh->execute;
	
	while (my $data = $testh->fetchrow_hashref('NAME_lc')) {
		push @tariff, {
			FROMDATE => UnixDate($data->{fromdate}, "%e %b %y"),
			TODATE => UnixDate($data->{todate}, "%e %b %y"),
			ROOMTYPE => $data->{roomtype},
			AC => $data->{ac},
			MEALPLAN => $data->{hotelmealplan},
			SINGLE => round($data->{singletotalcurr}),
			DOUBLE => round($data->{doubletotalcurr}),
			TRIPLE => round($data->{tripletotalcurr}),
		};
	}
	
	my $tpl = $app->load_tmpl('hoteltariff.tpl', die_on_bad_params => 0);
	$tpl->param(TARIFF => \@tariff);

	return $tpl->output;
}

sub round {
	my($number) = shift;
	return int($number + .5 * ($number <=> 0));
}

sub firstpara {
	my $str = shift;
	$str = addptags($str);
	$str =~ /^\<p class=\"writeup\"\>(.*?)\<\/p\>/;
	return $1;
}

sub boldify {
	my $str = shift;
	
	$str =~ s/\{/\<strong\>/gm;
	$str =~ s/\}/\<\/strong\>/gm;
	
	return $str;
}

sub h4ify {
	my $str = shift;
	
	$str =~ s/\{/\<h4\>/gm;
	$str =~ s/\}/\<\/h4\>/gm;
	
	return $str;
}

sub linkify {
	
	my $str = shift;
	my $sid = shift;
	my $lstr = '';

	while ( $str =~ /(.*?)\[(.*?)\](.*)/sm ) {
		my ($name, $id) = split(/\-/, $2);
		my $city = OdysseyDB::City->retrieve(cities_id => $id);
		my $url = $city->url;
		$lstr = $lstr . $1 . " <a href=\"/city/$url\">$name</a>";
		$str = $3;
	}
	$lstr = $lstr . $str;
	return $lstr;
}


sub testtop {

	my $app = shift;
	my $cityid = $app->query->param('id');
	

	my @tophotels;
	foreach (OdysseyDB::Hotel->search_topofline_bycity($cityid)) {
		push @tophotels, {
			HOTELID => $_->addressbook_id,
			HOTELNAME => $_->organisation,
			HOTELWRITEUP => firstpara($_->description),
		};
	}
	
	return Dumper(\@tophotels);
}

sub getimg_attr {

	my $app = shift;
	my $img = $app->param('imgname');
	
	my @attrs = OdysseyDB::Image->search(imagename => $img);
	
	my $retval =  @attrs ? {alt => $attrs[0]->alttag, title => $attrs[0]->title} : {alt => '', title => ''};
	return JSON->new->utf8(1)->encode($retval);
}