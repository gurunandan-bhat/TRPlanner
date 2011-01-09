package Odyssey::Init;

use strict;
use warnings;

use lib qw{../};

use base qw(Odyssey);

use OdysseyDB::City;
use OdysseyDB::Hotel;
use OdysseyDB::QuotationCity;
use OdysseyDB::Quotation;
use OdysseyDB::QuotationTicket;
use OdysseyDB::WebText;
use OdysseyDB::WebPage;
use OdysseyDB::Consultants;

use Date::Manip;
use Date::Calc qw(Delta_Days);

use Data::Dumper;

our $VERSION = '0.01';

# Preloaded methods go here.

sub setup {
	my $app = shift;
	
	$app->mode_param('mode');

	$app->run_modes(
		home =>'home',
		about => 'about',
		people => 'people',
		contact => 'contact',
		itineraries => 'itineraries',
		links => 'links',
		legal => 'legal',
		init => 'init',
		start => 'start',
		restart => 'restart',
		end_tour => 'end_tour',
		login => 'login',
		logout => 'logout',
		protected_save_favourites => 'protected_save_favourites',
		favourites => 'favourites',
		quotes => 'quotes',
		quotation_details => 'quotation_details',
		quote_modtours => 'quote_modtours',
	);

	$app->start_mode('home');
	$app->error_mode('errhndlr');
}


sub home {

	my $app = shift;

	my $tpl = $app->load_tmpl('new_index.tpl', die_on_bad_params => 0);

	my $main = OdysseyDB::WebText->retrieve(web_id => 1);

	my $discover = OdysseyDB::WebText->retrieve(web_id => 62);
	my $checkout = OdysseyDB::WebText->retrieve(web_id => 63);
	my $inspiration = OdysseyDB::WebText->retrieve(web_id => 64);
	my $follow = OdysseyDB::WebText->retrieve(web_id => 65);
	
	my $rt1 = OdysseyDB::WebText->retrieve(web_id => 66);
	my $rt2 = OdysseyDB::WebText->retrieve(web_id => 67);
	my $rt3 = OdysseyDB::WebText->retrieve(web_id => 68);
	my $rt4 = OdysseyDB::WebText->retrieve(web_id => 69);
	my $rt5 = OdysseyDB::WebText->retrieve(web_id => 70);
	my $rt6 = OdysseyDB::WebText->retrieve(web_id => 71);
	
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

	my @themes;
	foreach (OdysseyDB::Theme->retrieve_all) {
		push @themes, {
			THEMENAME => $_->title,
			THEMEURL => $_->url,
		};
	}
	
	my @regions;
	foreach (OdysseyDB::Region->retrieve_all) {
		push @regions, {
			REGIONNAME => $_->title,
			REGIONURL => $_->url,
		};
	}

	my @tours;
	foreach (OdysseyDB::Itineraries->retrieve_all) {
		next unless $_->readytours;
		push @tours, {
			TOURNAME => $_->title,
			TOURURL => $_->url,
		};
	}

	my $webpage = OdysseyDB::WebPage->retrieve(webpages_id => 6);

	$tpl->param(
		METADESCRIPTION => $webpage->metatype,
		METAKEYWORDS => $webpage->keywords,
		PAGETITLE => $webpage->descr,
		TITLE => $main->title,
		MAXHOMEIMAGES => $app->homeimages,
		WRITEUP => addptags(boldify($main->writeup)),
		DISCOVERTITLE => $discover->title,
		DISCOVERBODY => addptags($discover->writeup),
		CHECKOUTTITLE => $checkout->title,
		CHECKOUTBODY => addptags($checkout->writeup),
		INSPIRATIONTITLE => $inspiration->title,
		INSPIRATIONBODY => addptags($inspiration->writeup),
		FOLLOWTITLE => $follow->title,
		FOLLOWBODY => addptags($follow->writeup),
		RT1TITLE => $rt1->title,
		RT1BODY => h4ify($rt1->writeup),
		RT2TITLE => $rt2->title,
		RT2BODY => h4ify($rt2->writeup),
		RT3TITLE => $rt3->title,
		RT3BODY => h4ify($rt3->writeup),
		RT4TITLE => $rt4->title,
		RT4BODY => h4ify($rt4->writeup),
		RT5TITLE => $rt5->title,
		RT5BODY => h4ify($rt5->writeup),
		RT6TITLE => $rt6->title,
		RT6BODY => h4ify($rt6->writeup),
		STATES => \@states,
		CITIES => \@cities,
		THEMES => \@themes,
		REGIONS => \@regions,
		TOURS => \@tours,
	);		
	return $tpl->output;
}

sub init {
	# init() displays the "first Page" a form for the prospective traveler 
	# to fill in and customize his tour. If an old custom tour is found
	# the page displays a summary of the stored tour. Re-submitting the 
	# form automatically deletes the saved tour and resets the session.
	# The form is handled by start() below.


	my $app = shift;

	my $startcity = startcities();
	
#	return '<pre>' . Dumper($startcity) . '</pre>';
	
	my @arrcity = grep $_->{airport}, @{$startcity};

	my $arrtpl = $app->load_tmpl('arrcities_form.tpl', die_on_bad_params => 0);
	$arrtpl->param(ARRCITIES => \@arrcity);
	
	my $starttpl = $app->load_tmpl('startcities_form.tpl', die_on_bad_params => 0);
	$starttpl->param(STARTCITIES => $startcity);
	
	my $tpl = $app->load_tmpl('form.tpl', die_on_bad_params => 0);
	$tpl->param(
		ARRCITYOPTIONS => $arrtpl->output,
		STARTCITYOPTIONS => $starttpl->output,
		TITLE => OdysseyDB::WebText->retrieve(web_id => 33)->title,
		TEXT => OdysseyDB::WebText->retrieve(web_id => 33)->writeup,
		LOGINTEXT => addptags(OdysseyDB::WebText->retrieve(web_id => 30)->writeup),
	);

	return $tpl->output;
}

sub about {

	my $app = shift;

	my $tpl = $app->load_tmpl('about.tpl', die_on_bad_params => 0);

	my $webpage = OdysseyDB::WebPage->retrieve(webpages_id => 1);
	$tpl->param(
		METADESCRIPTION => $webpage->metatype,
		METAKEYWORDS => $webpage->keywords,
		PAGETITLE => $webpage->descr,
		ABOUTTP => addptags(boldify(OdysseyDB::WebText->retrieve(web_id => 8)->writeup)),
		ABOUTODC => addptags(boldify(OdysseyDB::WebText->retrieve(web_id => 9)->writeup)),
		ABOUTTEAM => addptags(boldify(OdysseyDB::WebText->retrieve(web_id => 31)->writeup)),
	);
	
	return $tpl->output;
}

sub people {

	my $app = shift;

	my $tpl = $app->load_tmpl('people.tpl', die_on_bad_params => 0);

	my @consultants = map {{
		ID => $_->consultants_id,
		NAME => $_->consultant,
		WRITEUP => $_->writeup,
	}} OdysseyDB::Consultants->search(addressbook_id => 68);

	my $webpage = OdysseyDB::WebPage->retrieve(webpages_id => 24);
	$tpl->param(
		METADESCRIPTION => $webpage->metatype,
		METAKEYWORDS => $webpage->keywords,
		PAGETITLE => $webpage->descr,
		CONSULTANTS => \@consultants,
	);

	return $tpl->output;
}

sub contact {

	my $app = shift;

	my $tpl = $app->load_tmpl('contact.tpl', die_on_bad_params => 0);

	my $webpage = OdysseyDB::WebPage->retrieve(webpages_id => 4);
	$tpl->param(
		METADESCRIPTION => $webpage->metatype,
		METAKEYWORDS => $webpage->keywords,
		PAGETITLE => $webpage->descr,
		WRITEUP => boldify(addptags(OdysseyDB::WebText->retrieve(web_id => 28)->writeup)),
		LEGALESE => OdysseyDB::WebText->retrieve(web_id => 40)->writeup,
	);

	return $tpl->output;
}

sub itineraries {

	my $app = shift;

	my $tpl = $app->load_tmpl('itineraries.tpl', die_on_bad_params => 0);
	return $tpl->output;
}

sub links {
	
	my $app = shift;

	my $sidebar = {
		'12' => 'WHYTRAVEL',
		'13' => 'RESPTRAVEL',
		'17' => 'BEFORETRAVEL',
		'21' => 'WHATEXPECT',
		'73' => 'HOWTOPLAN',
	};

	my $metakey = {
		12 => 8,
		13 => 30,
		17 => 2,
		21 => 29,
		73 => 40,
	};

	my $web_id = $app->param('text');

	my $webpage = OdysseyDB::WebPage->retrieve(webpages_id => $metakey->{$web_id});
	my $text = OdysseyDB::WebText->retrieve(web_id => $web_id);

	my @sideitems;
	my $sidetitle;
	if (my $pageid = $app->param('webpage')) {
		
#		die({type => 'error', msg => "Page is $pageid"});
		$sidetitle = OdysseyDB::WebPage->retrieve(webpages_id => $pageid)->pagename;
		
		@sideitems = map {{
			SIDEITEMID => $_->web_id,
			SIDEITEMTITLE => $_->title,
			SIDEITEMTEXT => $_->writeup,
		}} OdysseyDB::WebText->search(webpages_id => $pageid);
	};
	
		
	my $title = $text->title;
	my $writeup = $text->writeup;	
	
	my $tpl = $app->load_tmpl('default.tpl', die_on_bad_params => 0);
	
#	return Dumper(\@sideitems);
	
	$tpl->param(
		METADESCRIPTION => $webpage->metatype,
		METAKEYWORDS => $webpage->keywords,
		PAGETITLE => $webpage->descr,
		WEBID => $web_id,
		TITLE => $title,
		WRITEUP => boldify(addptags($writeup)),
		$sidebar->{$app->query->param('id')} => 1,
		SIDEITEMS => \@sideitems,
		RIGHTHDR => $sidetitle || OdysseyDB::WebText->retrieve(web_id => 58)->title,
		TEXTINDEX => ($web_id == 17) ? 1 : 0,
	);
	
	return $tpl->output;
}

sub legal {
	
	my $app = shift;
	my $web_id = $app->param('text');
	my $text = OdysseyDB::WebText->retrieve(web_id => $web_id);

	my $metakey = {
		16 => 10,
		35 => 27,
		15 => 28,
	};

	my $webpage = OdysseyDB::WebPage->retrieve(webpages_id => $metakey->{$web_id});

	my $title = $text->title;
	my $writeup = $text->writeup;	
	
	my $tpl = $app->load_tmpl('legal.tpl', die_on_bad_params => 0);
	
	$tpl->param(
		METADESCRIPTION => $webpage->metatype,
		METAKEYWORDS => $webpage->keywords,
		PAGETITLE => $webpage->descr,
		WEBID => $web_id,
		TITLE => $title,
		WRITEUP => boldify(addptags($writeup)),
	);
	
	return $tpl->output;
}

# start() is the form:action of init(). Initializes tour.  

sub start {
	# TODO make sure that you come into this mode only via a post from the index form. 

	my $app = shift;
	my $q = $app->query;
	
	# Start Form Input Parameters
	my $leadname = $q->param('leadname');
	my $pax = $q->param('pax');
	
	my $hotelcategory = $q->param('hotelcategory');
	my $single = $q->param('single');
	my $double = $q->param('double');
	my $twin = $q->param('twin');
	my $triple = $q->param('triple');

	my $entrance = $q->param('entrance') ? 1 : 0;

	my $arrdate = UnixDate($q->param('arrdate'), '%m/%d/%Y');
	my $arrtime = $q->param('arrtimehh') . ':' . $q->param('arrtimemm');
	my $arrplace = $q->param('arrplace');
	my $arrflt = $q->param('arrflt');

	my $startplace = $q->param('startplace');

	my $depdate = UnixDate($q->param('depdate'), '%m/%d/%Y');
	my $depplace = $q->param('depplace');
	my $depflt = $q->param('depflt');
	# End Form Input Parameters
	
	my $session = $app->session;

	# TODO Session Parameters stay the same. Consider deleting the old session 
	my $quotationid = OdysseyDB::Quotation->maximum_value_of('quotations_id');
	++$quotationid;
		
	OdysseyDB::Quotation->insert({
		quotations_id => $quotationid,
		quotationdate => _get_todays_date(),
		paxname => $leadname,
		numpax => $pax,
		hoteltypes_id => $hotelcategory,
		numsingles => $single,
		numdoubles => $double,
		numtwins => $twin,
		numtriples => $triple,
		entrancefees => $entrance,
		startcities_id => $startplace,
		endcities_id => $depplace,
		placefrom => $arrplace,
		startdate => $arrdate,
		eta => $arrdate,
		flightno => $arrflt,
		trial => 1,
		web => 1,
	});

	my $dateout = $arrdate . ' ' . $arrtime;
	if ($startplace != $arrplace) {

		# All goes downhill from here. Terrible. Would have done differently if not 
		# for the cold and mild fever. If the arrival place and the start place are 
		# different, mimic Odyssey::Itinerary::transit() - Travel from arrplace to
		# startplace, Record in QuotationCities, QuotationTickets but not QuotationHotels
		# and then start tour from startplace as if nothing happened.
		
		# TODO Seek redemption for this. Grovel while seeking.

		my $cityid = $startplace;
		my $days = 0;

		my $depdatetime = "$arrdate $arrtime";
		$app->_get_routes($arrplace, $startplace, $depdatetime);
		
		# optionlist is set in _get_routes. select the first option.
		my $travelopts = 1;
		my @optionlist = @{$app->session->param('optionlist')};
		my @selectedoption;

		# move option number 1 to selected option and reset arrival 
		for (@optionlist) {
			next if ($_->{optionno} < $travelopts);
			last if ($_->{optionno} > $travelopts);
			push @selectedoption, $_;
		}

		# leave arrplace the same day and set on towards startplace 
		my $datein = UnixDate($arrdate, '%m/%d/%Y');
		my $dateout = $selectedoption[0]->{departure};
		my $mystatus = $app->session->param('mystatus');

		# Mark your visit to arrplace even if you arrived and then quickly set off
		my $quocitiesid = OdysseyDB::QuotationCity->maximum_value_of('quocities_id') + 1;
		OdysseyDB::QuotationCity->insert({
			quocities_id => $quocitiesid,
			quotations_id => $quotationid,
			datein => $datein,
			dateout => $dateout,
			tocities_id => $arrplace,
		});

		# Mark the travel mode to startplace	
		my $quoticketsid = OdysseyDB::QuotationTicket->maximum_value_of('quotickets_id') + 1;
		for (@selectedoption) {
	
			last if ($_->{fromcities_id} == $_->{tocities_id});

			OdysseyDB::QuotationTicket->insert({
				tickets_id => $_->{mode},
				quotickets_id => $quoticketsid,
				quocities_id => $quocitiesid,
				from_cities_id => $_->{fromcities_id},
				to_cities_id => $_->{tocities_id},
				trainno => $_->{trainno},
				flightno => $_->{modeno},
				etd => $_->{departure},
				eta => $_->{arrival},
				quotations_id => $quotationid,
			});
			++$quoticketsid;
		}
	}

	$app->session->param(mystatus => {
		quotationid => $quotationid,
		maxdaynum => _get_days_between($arrdate, $depdate) + 1,
		dateout => UnixDate($dateout, '%m/%d/%Y'),
		defaulthotelcategory => $hotelcategory,
	});	
	$app->session->flush; # About to be redirected - cgiapp_postrun will not be called. Hence Flush!

	# pretend you never started at arrplace!
	return $app->redirect("travel.cgi?mode=move_to&srcid=$startplace&destid=$startplace");
}

sub restart {
	my $app = shift;
	my $tpl = $app->load_tmpl('killsession.tpl', die_on_bad_params => 0);
	
	if ($app->query->request_method() eq 'GET') {

		if (my $mystatus = $app->session->param('mystatus')) {

			my $quotationid = $mystatus->{quotationid};
			
			my @displaycities = my @displayhotels = my @displaytickets;
			my @cities = OdysseyDB::QuotationCity->search(quotations_id => $quotationid);
			for my $city (@cities) {
				push @displaycities, {
					CITYID => $city->tocities_id,
					CITYNAME => OdysseyDB::City->retrieve($city->tocities_id)->city,
					DATEIN => UnixDate($city->datein, '%b %d, %Y'),
					DATEOUT => UnixDate($city->dateout, '%b %d, %Y'),
				};
				my @hotels = OdysseyDB::QuotationAccommodation->search(quocities_id => $city->quocities_id);
				for my $hotel (@hotels) {
					push @displayhotels, {
						HOTELID => $hotel->hoteladdressbook_id,
						HOTELNAME => OdysseyDB::Hotel->retrieve($hotel->hoteladdressbook_id)->organisation,
						HOTELNIGHTS => $hotel->nights, 
					};
				}
				my @tickets = OdysseyDB::QuotationTicket->search(quocities_id => $city->quocities_id);
				for my $ticket (@tickets) {
					push @displaytickets, {
						FROM => OdysseyDB::City->retrieve($ticket->from_cities_id)->city,
						TO => OdysseyDB::City->retrieve($ticket->to_cities_id)->city,
						MODE => $ticket->flightno,
						DEP => UnixDate($ticket->etd, '%b %d, %Y %H:%M'),
						ARR => UnixDate($ticket->eta, '%b %d, %Y %H:%M'), 
					};
				}
			}

			$tpl->param(CITYSTOPS => \@displaycities);
			$tpl->param(HOTELS => \@displayhotels);
			$tpl->param(TICKETS => \@displaytickets);
			
			use Data::Dumper;
			$tpl->param(
				NOTCLEAN => 1,
				DUMP => $app->session->id . ' ' . Dumper($mystatus),
			);
		}
		else {
			$tpl->param(
				NOTCLEAN => 0,
			);	
		}
	}
	elsif ($app->query->request_method() eq 'POST') {

		$app->session->delete();
		$tpl->param(
			NOTCLEAN => 0,
		);	
	} 

	return $tpl->output;
}

sub _get_todays_date {
	my ($dd, $mm, $yy) = (localtime)[3..5];
	$mm = $mm + 1;
	$yy = $yy + 1900;
	return "$mm/$dd/$yy";
}

sub _get_days_between {
	my $datein = shift;
	my $dateout = shift;
	my ($yearin, $monthin, $dayin) = split /\s+/, UnixDate($datein, "%Y %f %e");
	my ($yearout, $monthout, $dayout) = split /\s+/, UnixDate($dateout, "%Y %f %e");
	return Delta_Days($yearin, $monthin, $dayin, $yearout, $monthout, $dayout);
}

sub startcities {

	my $dbh = OdysseyDB::City->db_Main();
	$dbh->{FetchHashKeyName} = 'NAME_lc';
	
	my $qry = "select cities_id, city, airport, case cities_id when 103 then 'selected=\"selected\"' else '' end as selected from cities where nighthalt = 1 order by city";
	my $sth = $dbh->prepare($qry);
	$sth->execute;
	
	return $sth->fetchall_arrayref({});
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
1;
