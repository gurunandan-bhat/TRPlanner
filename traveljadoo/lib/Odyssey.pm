package Odyssey;

use strict;
use warnings;

use lib qw(../lib/);

use base qw(CGI::Application);

use CGI::Application::Plugin::Config::Simple;
use CGI::Application::Plugin::Session;
use CGI::Application::Plugin::DBH qw{dbh_config dbh};
use CGI::Application::Plugin::Authentication;
use CGI::Application::Plugin::Redirect;

use Date::Manip;
use Date::Calc qw{Delta_Days};
use URI::Escape;
use URI;
use Email::Valid;

use Date::Manip;

use MIME::Lite;

use OdysseyDB::WebText;

use Data::Dumper;

our $VERSION = '0.01';

sub cgiapp_init {
	
	my ($app, $param) = @_;
		
	$app->config_file($param->{cfg_file});
	$app->tmpl_path( $app->config_param('default.TemplatePath') );
	
	CGI::Session->name($app->config_param('default.CookieName'));

	$app->session_config(
		CGI_SESSION_OPTIONS => [
			'driver:sqlite',
			$app->query,
			{
				DataSource => $app->config_param('default.LocalDBFile'),
				TableName => 'cgisessions',
				IdColName => 'sessionid',
				DataColName => 'sessiondata',
				ColumnType => 'binary',
			},
		],
		DEFAULT_EXPIRY => '+10y',
		COOKIE_PARAMS => {
			-name => 'ODYSSEYPALM',
			-expires => '+10y',
		},
	);
	CGI::Session->name('ODYSSEYPALM');
	
	$app->dbh_config($app->config_param('UserDBDSN'), '', '',);
	
	$app->authen->config(
		DRIVER => 'Dummy',
		STORE => 'Session',
		LOGIN_RUNMODE => 'login',
		LOGOUT_RUNMODE => 'logout',
	);

}

sub cgiapp_prerun {
	
	my $app = shift;
	my $rm = shift;
	
	return if ($rm eq 'login') || ($rm eq 'logout');

	my $uri = URI->new($app->query->url(-base => 1));
	my $host = $uri->host;
	$host =~ s/^www\.//;
	$host =~ s/\./\-/g;

	my $googlekey = $app->config_param($host);

	my $foot1 = OdysseyDB::WebText->retrieve(web_id => 60)->writeup;
	my $foot2 = OdysseyDB::WebText->retrieve(web_id => 61)->writeup;
	
	
	my $set_status = sub {
		my ($c, $ht_params, $tmpl_params, $tmpl_file) = @_;

		$ht_params->{die_on_bad_params} = 0;
		
		$tmpl_params->{THISURL} = $app->query->url;
		$tmpl_params->{GOOGLEKEY} = $googlekey;
		$tmpl_params->{FOOTERTEXT} = "$foot1<br /><br />$foot2";
		$tmpl_params->{AFFILIATE} = ($uri->host =~ /travelwell/) ? 1 : 0;
	};

	$app->add_callback('load_tmpl', $set_status);
}

sub errhndlr {
	my $app = shift;
	my $err = shift;

	my $url = $app->query->url();
	my $remoteip = $ENV{REMOTE_ADDR};
	
	my $tpl = $app->load_tmpl('error.tpl');

	my $errstr = "Remote IP: $remoteip<br />";
	my $errcat = 'error';
	if (ref($err) eq 'HASH') {
		$errstr .= "Deliberately Died at $url: " . $err->{msg} . '<br />';
		$errcat = $err->{type};
	}
	else {
		$errstr .= "Unexpected System Error at $url: $err<br />";
	}

	$tpl->param(
		CLASS => $errcat,
		MSG => $errstr,
	);

	my $msg = MIME::Lite->new(
		To => 		'hans@odyssey.co.in',
		From => 	'Travellers Palm Administrator <webmaster@travellers-palm.com>',
		Subject => 	'Error Happened!',
		Type => 	'multipart/related',
		CC => 		'admin@odyssey.co.in, bhat.gurunandan@gmail.com', 
	);
	
	$msg->attach(
		Type => 'text/html',
		Data => "<p>$errstr</p>",
	);

	MIME::Lite->send(
		'smtp', 
		'travellers-palm.com', 
		Timeout => 30,
		AuthUser => 'webmaster+travellers-palm.com',
		AuthPass => 'ip31415',
		Debug => 1,
	);
	
	$msg->send;

	return $tpl->output;
}

sub cgiapp_postrun {
	my $app = shift;
	$app->session->flush if $app->session_loaded;
}

sub _get_routes {
	
	# Does two things: Calls a stored procedure p_RouteFnder to get options to
	# travel from one place to another given the two ponts and a departure time
	# Additionally it stores the routes in a session so that the form need not
	# pass all attribs of a route on submit. On submit only an "option number"
	# is passed and the action looks up other attributes of a route in session
	 
	my $app = shift;
	my $from = shift;
	my $to = shift;

	my @optionlist;	

	# dummy just in case the starting and ending points are the same. The stored
	# proc would die if asked to travel back to the source
	
	if ($to == $from) {
		push @optionlist, {
			optionno => 1,
			fromcities_id => $from,
			tocities_id => $to,
			mode => undef,
			modeno => undef,
			trainno => undef,
			departure => undef,
			arrival => ($app->session->param('mystatus') ? $app->session->param('mystatus')->{dateout} : '01/01/2008 09:00'),
		};

		$app->session->param(optionlist => \@optionlist);

		return;
	}

	my $dbh = OdysseyDB::City->db_Main();
	$dbh->syb_date_fmt('ISO');

	my $datetime = $dbh->quote(shift);

	my $testh = $dbh->prepare("exec p_RouteFinder_x $datetime, $from, $to, 3, 1, null");
	$testh->execute;

	# Returns:	
	# options_id (serial)
	# optionno (serial within an option)
	# fromcities_id
	# tocities_id
	# fromcity (name)
	# tocity (name)
	# mode (mode id)
	# modestr ("Train", "Car", "Air" etc.) 
	# modeno ("Car" or Flight No "IC 234", null for train)
	# trainno (Train Number "1245")
	# departure (timestamp)
	# arrival (timestamp)
	# maxoption (?)
	# hops
	# modepreference (Sort Order?)
	
	my $travelopts = [[]];
	my $modeopts =[[]];
	my $link = [];	
	my $parent_idx = -1;
	my $child_idx = 0;

	my $last_option = 0;

	while (my $res = $testh->fetchrow_hashref) {

		push @optionlist, { # optionlist is what goes into session - only optionno is posted
			optionno => $res->{optionno},
			fromcities_id => $res->{fromcities_id},
			tocities_id => $res->{tocities_id},
			mode => $res->{mode},
			modeno => $res->{modeno},
			trainno => $res->{trainno},
			departure => $res->{departure},
			arrival => $res->{arrival},
		};

		if ( $res->{optionno} == $last_option ) {
			++$child_idx;
		}
		else {
			++$parent_idx;
			$child_idx = 0;
			
			# You can "tweak" each option - this link does it. Look at Itinerary::otherroutes for details
			my $tmpstr = 'travel.cgi' .
				'?mode=otherroutes' .
				'&departure=' . $datetime . 
				'&from=' . $from .
				'&to=' . $to .
				'&hops=' . $res->{hops} .
				'&modepref=' . $res->{modepreference};
			
			$link->[$parent_idx] = $tmpstr;
		}

		# modeopts is used to construct a human friendly header for every route.
		$modeopts->[$parent_idx][$child_idx] = $res->{modestr};
		
		$travelopts->[$parent_idx][$child_idx] = { # For Display purposes only!
			opt_method => $res->{modeno},
			opt_source => $res->{fromcity}, 
			opt_departure => UnixDate($res->{departure}, "%e %b %H:%M"), 
			opt_destination => $res->{tocity}, 
			opt_arrival => UnixDate($res->{arrival}, "%e %b %H:%M"),
		};
		
		$last_option = $res->{optionno};
	}

	
	my $tpl = $app->load_tmpl('options_table.tpl', die_on_bad_params => 0, global_vars => 1,);
	
	$tpl->param(
		FROMCITY => $travelopts->[0][0]->{opt_source},
		TOCITY => $travelopts->[0][-1]->{opt_destination},
	);
	
	
	my $modedesc = join(', ', @{ $modeopts->[0] }); 
	$tpl->param(
		HDR1 => $modedesc,
		OPT1 => $travelopts->[0],
		HASTRAIN1 => 1, # ($modedesc =~ /train/i) ? 1 : undef,
		LINK1 => $link->[0],
	);
	
	if ( $modeopts->[1] ) {
		$modedesc = join(' and ', @{ $modeopts->[1] }); 
		$tpl->param(
			HDR2 => $modedesc,
			OPT2 => $travelopts->[1],
			HASTRAIN2 => 1, # ($modedesc =~ /train/i) ? 1 : undef,
			LINK2 => $link->[1],
		);
	}
	
	if ( $modeopts->[2] ) {
		$modedesc = join(' and ', @{ $modeopts->[2] }); 
		$tpl->param(
			HDR3 => $modedesc,
			OPT3 => $travelopts->[2],
			HASTRAIN3 => 1, # ($modedesc =~ /train/i) ? 1 : undef,
			LINK3 => $link->[2],
		);
	}

	$app->session->param(optionlist => \@optionlist);
	
	return $tpl->output;
}

sub tour_summary {

	my $app = shift;
	
	# Every Hop in an itinerary is stored in the MS-SQL Database. See Itinerary::transit.
	# Should I read an itinerary from the MS-SQL database or should I just keep track 
	# using session variables? Not sure. 
	# So currently reading from MS-SQL Database - Reading a session would be faster - 
	# since session structs are stored on-disk: SQLite. But WTF.
	
	my $mystatus;
	return unless (($mystatus = $app->session->param('mystatus')) && (my $quotationid = $mystatus->{quotationid}));
	
	my $tpl = $app->load_tmpl('tour_summary.tpl', die_on_bad_params => 0, loop_context_vars => 1);
	
	my $paxname = OdysseyDB::Quotation->retrieve($quotationid)->paxname;
	return unless (my @cities = OdysseyDB::QuotationCity->search(quotations_id => $quotationid));

	my $startdate = $cities[0]->datein;
	
	# Cities visited so far
	my @displaycities;
	for my $city (@cities) {

		my $currcity = OdysseyDB::City->retrieve($city->tocities_id);

		my ($hotelname, $hotelnights);
		if (my @hotels = OdysseyDB::QuotationAccommodation->search(quotations_id => $quotationid, quocities_id => $city->quocities_id)) {
			my $hotel = $hotels[0];
			$hotelname = OdysseyDB::Hotel->retrieve($hotel->hoteladdressbook_id)->organisation;
			$hotelnights = $hotel->nights;
		}
		else {
			$hotelname = '';
			$hotelnights = 0;
		}
		
		push @displaycities, {
			CITYID => $city->tocities_id,
			CITYNAME => $currcity->city,
			DATEIN => UnixDate($city->datein, '%d %b %y'),
			DATEOUT => UnixDate($city->dateout, '%d %b %y'),
			CITYDESC => $currcity->oneliner,
			CITYHOTEL => $hotelname,
			CITYNIGHTS => _get_days_between($city->datein, $city->dateout),
			CITYDAYNUMIN => _get_days_between($startdate, $city->datein) + 1,
			CITYDAYNUMOUT => _get_days_between($startdate, $city->dateout) + 1,
		};
	}

	$tpl->param(CITYSTOPS => \@displaycities);

	my $table2 = '';
	my @datecal;
	my $maxdaynum = $app->session->param('mystatus')->{maxdaynum};
	if (@displaycities) {

		for my $city (@displaycities) {

			for ($city->{CITYDAYNUMIN} .. $city->{CITYDAYNUMOUT}) {
				my $tempday = $_ - 1;
				$datecal[$tempday] = {
					DAYNUM => $_,
					DAYDATE => UnixDate(DateCalc($startdate, "+ $tempday days"), "%a, %d %b %y"),
					CITY => $city->{CITYNAME},
					HOTEL => $city->{CITYHOTEL},
					OVERSTAYED => ($_ > $maxdaynum) ? 1 : undef,
				};
			}
		}
		$datecal[-1]->{HOTEL} = 'Ready to leave: &nbsp;';
		$datecal[-1]->{CITY} = ''; # Added so that the departure day has no city associated. Terrible! Requires second look. 
		
		my $drpdntpl = $app->load_tmpl('randomcities.tpl', die_on_bad_params => 0);
		my $drpdn;
		if (my @randomcities = OdysseyDB::City->search_randomcities) {
			my @randomdestination;
			for (@randomcities) {
				push @randomdestination, {
					RANDOMDESTID => $_->cities_id,
					RANDOMDESTNAME => $_->city,
					CURRID => 103,
				};
			}
			$drpdntpl->param(RANDOMDESTINATION => \@randomdestination);
			$drpdn = $drpdntpl->output;
				$datecal[-1]->{HOTEL} .= $drpdn;
		}
		
		my $currdaynum = $datecal[-1]->{DAYNUM};
		while ($currdaynum < $maxdaynum) {
				push @datecal, {
				DAYNUM => ++$currdaynum,
				DAYDATE => UnixDate(DateCalc($startdate, '+ ' . ($currdaynum - 1) .' days'), "%a, %d %b %y"),
				CITY => undef,
				HOTEL => undef,
			};
		}

		my $smalltpl = $app->load_tmpl('smalltable.tpl', die_on_bad_params => 0, loop_context_vars => 1);
		$smalltpl->param(DATECAL => \@datecal);
		$table2 = $smalltpl->output;
	}
	
	return {
		smalltable => $tpl->output,
		table => $table2,
		paxname => $paxname,
		depcityname => $displaycities[-1]{CITYNAME},
		depcityid => $displaycities[-1]{CITYID},
		depdate => $displaycities[-1]{DATEOUT},
		depdaynum => $displaycities[-1]{CITYDAYNUMOUT},
	};
}

sub _get_days_between {
	my $datein = shift;
	my $dateout = shift;
	my ($yearin, $monthin, $dayin) = split /\s+/, UnixDate($datein, "%Y %f %e");
	my ($yearout, $monthout, $dayout) = split /\s+/, UnixDate($dateout, "%Y %f %e");
	return Delta_Days($yearin, $monthin, $dayin, $yearout, $monthout, $dayout);
}

sub get_last_hotel {
	
	my $app = shift;
	
	# Gets the last hotel stayed in
	
	my $mystatus;
	my $hotelid = 0;
	if (($mystatus = $app->session->param('mystatus')) && (my $quotationid = $mystatus->{quotationid}))  {

		return unless (my @cities = OdysseyDB::QuotationCity->search(quotations_id => $quotationid));
		my $startdate = $cities[0]->datein;
		
		# Cities visited so far
		my @displaycities;
		for my $city (@cities) {
			my $currcity = OdysseyDB::City->retrieve($city->tocities_id);

			my ($hotelname, $hotelnights);
			if (my @hotels = OdysseyDB::QuotationAccommodation->search(quotations_id => $quotationid, quocities_id => $city->quocities_id)) {
				my $hotel = $hotels[0];
				$hotelid = $hotel->hoteladdressbook_id;
			}
		}
	}
	return $hotelid;
}

sub getmapcities {
	
	use JSON;
	use OdysseyDB::City;
		
	my @mapcities = map {{
		id => $_->cities_id, 
		city => $_->city, 
		oneliner => $_->oneliner || 'No Oneliner Available',
		latitude => $_->latitude,
		longitude => $_->longitude,
	}} OdysseyDB::City->search_randomcities;
	
	return JSON->new->utf8(1)->pretty(1)->encode(\@mapcities);
}

sub getmappath {

	use JSON;
	use OdysseyDB::QuotationCity;
	use OdysseyDB::City;
	
	my $app = shift;
	
	my @data = ();
	
	my $mystatus;
	return JSON->new->utf8(1)->pretty(1)->encode(\@data)
		unless (($mystatus = $app->session->param('mystatus')) && (my $quotationid = $mystatus->{quotationid}));
	
	@data = map {{
		id => $_->tocities_id,
		latitude => OdysseyDB::City->retrieve(cities_id => $_->tocities_id)->latitude,
		longitude => OdysseyDB::City->retrieve(cities_id => $_->tocities_id)->longitude,
	}} OdysseyDB::QuotationCity->search(quotations_id => $quotationid, {order_by => 'quocities_id'});

	return JSON->new->utf8(1)->pretty(1)->encode(\@data);
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

	$app->redirect('index.cgi?mode=restart')	
}

sub cityimages {
	my $app = shift;
	my $cityid = shift;
	
	opendir my $imgdir, $app->config_param('default.ImagePath') . '/city' or die "Cannot Open Directory: $!";

	my $pattern = 'city_' . $cityid . '_large';
	my @files = grep /$pattern/, readdir($imgdir);

	return scalar(@files);
}

sub hotelimages {
	my $app = shift;
	my $hotelid = shift;
	
	opendir my $imgdir, $app->config_param('default.ImagePath') . '/hotel' or die "Cannot Open Directory: $!";
 
	my $pattern = 'hotel_' . $hotelid . '_large';
	my @files = grep /$pattern/, readdir($imgdir);

	return scalar(@files);
}

sub homeimages {
	my $app = shift;
	my $hotelid = shift;
	
	opendir my $imgdir, $app->config_param('default.ImagePath') . '/home' or die "Cannot Open Directory: $!";
 
	my $pattern = 'hp_';
	my @files = grep /$pattern/, readdir($imgdir);

	return scalar(@files);
}

sub itineraryimages {
	
	use OdysseyDB::Itineraries;
	
	my $app = shift;
	my $itintypedir = shift;
	my $itinid = shift;
	
	my $itin = OdysseyDB::Itineraries->retrieve(fixeditin_id => $itinid);
	
	opendir my $imgdir, $app->config_param('default.ImagePath'). '/' . $itintypedir or die "Cannot Open Directory: $!";
	
	my $prefix = $itin->readytours ? 'rt' : 'mod';
	
	my $pattern = $prefix . '_' . $itinid . '_[0-9]';
	
	my @files = grep /$pattern/, readdir($imgdir);

	return scalar(@files);
}

sub login {

	my $app = shift;

	my $tpl = $app->load_tmpl('login.tpl', die_on_bad_params => 0);
	my $q = $app->query;
	my $auth = $app->authen;
	
	my $dest = $q->param('destination');

	my ($title, $text);
	if ($q->self_url =~ /mode\=init/) {
		$title = OdysseyDB::WebText->retrieve(web_id => 33)->title;
		$text = boldify(addptags(OdysseyDB::WebText->retrieve(web_id => 33)->writeup));
	}
	else {
		$title = OdysseyDB::WebText->retrieve(web_id => 36)->title;
		$text = boldify(addptags(OdysseyDB::WebText->retrieve(web_id => 36)->writeup));
	}
	
	$tpl->param(
		ACTION => $q->url( -absolute => 1, -path_info => 1 ),
		DESTINATION => $q->param('destination') || $q->self_url,
		TITLE => $title,
		TEXT => $text,
	);

	$tpl->param(ATTEMPTS => $auth->login_attempts) 
		if ( (! $auth->is_authenticated ) && $auth->login_attempts );

	return $tpl->output;
}

sub logout {
	my $app = shift;
	$app->redirect('index.cgi');
}

sub lastlogin {
	my $app = shift;
	if ($app->authen->username) {
		return UnixDate("epoch " . $app->authen->last_login, "%a, %e %b %y %H:%M:%S");
	}
	else {
		return "";
	}
}

sub save_favourites {
	
	my $app =shift;
	my $itin = $app->query->param('favid');
	my $type = $app->query->param('favtype');
	my $from = 	OdysseyDB::Itineraries->retrieve(fixeditin_id => $itin)->readytours ? 'Tour' : 'Module',
	
	my $favlink = 'itineraries.cgi?mode=favourites';
	
	my $retval;
	if (my $username = $app->authen->username) {
		
		my $sth = $app->dbh->prepare("select count(*) from favourites where username = '$username' and id = $itin");
		$sth->execute;
		my ($count) = $sth->fetchrow_array;
		
		if (! $count) {
			$sth = $app->dbh->prepare("insert into favourites (username, id, type, addedon) values ('$username', $itin, '$type', '" . UnixDate('now', '%Y-%m-%d %H:%M:%S') . "')");
			$sth->execute;
		}
		
		$sth = $app->dbh->prepare("select count(*) from favourites where username = '$username'");
		$sth->execute;
		my ($favcount) = $sth->fetchrow_array;

		$retval = {
			loggedin => 1,
			favcount => $favcount,
			from => $from,
		};
	}
	else {
		$retval = {
			loggedin => 0,
			favcount => undef,
			from => $from,
		};
	}

	return JSON->new->utf8(1)->encode($retval);
}

sub save_quotes {
	
	my $app =shift;
	my $itin = $app->query->param('itinid');
	
	my $from = 	OdysseyDB::Itineraries->retrieve(fixeditin_id => $itin)->readytours ? 'Tour' : 'Module',
	
	my $quotelink = 'itineraries.cgi?mode=quotes';
	
	my $retval;
	if (my $username = $app->authen->username) {
		
		my $sth = $app->dbh->prepare("select count(*) from quotes where username = '$username' and id = $itin");
		$sth->execute;
		my ($count) = $sth->fetchrow_array;
		
		if (! $count) {
			$sth = $app->dbh->prepare("insert into quotes (username, id, addedon) values ('$username', $itin, '" . UnixDate('now', '%Y-%m-%d %H:%M:%S') . "')");
			$sth->execute;
		}
		
		$sth = $app->dbh->prepare("select count(*) from quotes where username = '$username'");
		$sth->execute;
		my ($quotecount) = $sth->fetchrow_array;

		$retval = {
			loggedin => 1,
			quotecount => $quotecount,
			from => $from,
		};
	}
	else {
		$retval = {
			loggedin => 0,
			quotecount => undef,
			from => undef,
		};
	}

	return JSON->new->utf8(1)->encode($retval);
}

sub protected_save_favourites {
	my $app = shift;

	my $q = $app->query;
	
	my $type = $q->param('favtype');
	my $id = $q->param('favid');
	my $registered = $q->param('registered');

	my $username = $q->param('username') || $app->session->param('username');
	
	$app->session->param(username => $username);
	
	my $validuser = '';
	my $count = 0;
	
	if (Email::Valid->address($username)) {
		
		$validuser = 1;

		my $sth = $app->dbh->prepare("select count(*) from favourites where username = '$username' and id = $id and type = '$type'");
		$sth->execute;
		($count) = $sth->fetchrow_array;
		
		if (! $count) {
			$sth = $app->dbh->prepare("insert into favourites (username, id, type, addedon) values ('$username', $id, '$type', '" . UnixDate('now', '%Y-%m-%d %H:%M:%S') . "')");
			$sth->execute;
			++$count;
		}
	}
	else {
		$validuser = 0;
	}
	
	my $json = {
		validuser => $validuser,
		count => $count,
	};
	
	return JSON->new->utf8(1)->encode($json);
}

sub protected_save_quotes {
	my $app = shift;

	my $itin = $app->query->param('itinid');
	my $from = $app->query->param('from');
	
	my $retval;
	if (my $username = $app->authen->username) {
		
		my $sth = $app->dbh->prepare("select count(*) from quotes where username = '$username' and id = $itin");
		$sth->execute;
		my ($count) = $sth->fetchrow_array;
		
		if (! $count) {
			$sth = $app->dbh->prepare("insert into quotes (username, id, addedon) values ('$username', $itin, '" . UnixDate('now', '%Y-%m-%d %H:%M:%S') . "')");
			$sth->execute;
		}
		$app->redirect($from);
	}
	else {
		die({type => 'error', msg => 'Not logged in - Must be a screwup?'});
	}
}

sub favourites {
	
	my $app = shift;
		
	my $tpl = $app->load_tmpl('favourites.tpl', die_on_bad_params => 0);

	my $favs;
	my $username = $app->session->param('username');
	
	if (! $username) {

		$tpl->param(NOTLOGGEDIN => 1);
		return $tpl->output;
	}
	my $sth = $app->dbh->prepare("select id, type, addedon from favourites where username = '$username' order by type, addedon");
	$sth->execute;
	
	while (my $row = $sth->fetchrow_hashref('NAME_lc')) {
		push @{$favs->{$row->{type}}}, {
			id => $row->{id}, 
			addedon => $row->{addedon}
		}; 
	}

	my @itins;
	foreach (@{$favs->{itin}}) {
		my $itin = OdysseyDB::Itineraries->retrieve(fixeditin_id => $_->{id});

		my $sth = $app->dbh->prepare("select count(*) from quotes where username = '$username' and id = " . $_->{id});
		$sth->execute;
		my ($isquoted) = $sth->fetchrow_array;
		
		push @itins, {
			ID => $_->{id},
			NAME => $itin->title,
			ONELINER => $itin->oneliner,
			DESC => $itin->adv,
			DURATION => $itin->duration,
			COST => $itin->prices,
			SHOWQUOTE => $isquoted ? 'This Itinerary is in your Quotation Basket. Click <a href="itineraries.cgi?mode=quotes">here</a> to view basket.' : undef,
			ADDQUOTE => $isquoted ? undef : qq{<a href="#" itinid=} . $_->{id} . qq{>Add this itinerary to my Quotation basket</a>},
		} unless $itin->readytours;
	}
	
	my @rtours;
	foreach (@{$favs->{itin}}) {
		my $rtour = OdysseyDB::Itineraries->retrieve(fixeditin_id => $_->{id});

		my $sth = $app->dbh->prepare("select count(*) from quotes where username = '$username' and id = " . $_->{id});
		$sth->execute;
		my ($isquoted) = $sth->fetchrow_array;

		push @rtours, {
			ID => $_->{id},
			NAME => $rtour->title,
			ONELINER => $rtour->oneliner,
			DESC => $rtour->adv,
			DURATION => $rtour->duration,
			COST => $rtour->prices,
			SHOWQUOTE => $isquoted ? 'This Itinerary is in your Quotation Basket. Click <a href="itineraries.cgi?mode=quotes">here</a> to view basket.' : undef,
			ADDQUOTE => $isquoted ? undef : qq{<a href="#" itinid=} . $_->{id} . qq{>Add this itinerary to my Quotation basket</a>},
		} if $rtour->readytours;
	}

	my @cities;
	foreach (@{$favs->{city}}) {
		my $city = OdysseyDB::City->retrieve(cities_id => $_->{id});
		push @cities, {
			ID => $_->{id},
			NAME => $city->city,
			DESC => firstpara($city->writeup),
		};
	}

	my @hotels;
	foreach (@{$favs->{hotel}}) {
		my $itin = OdysseyDB::Hotel->retrieve(addressbook_id => $_->{id});
		push @hotels, {
			ID => $_->{id},
			NAME => $itin->organisation,
			DESC => firstpara($itin->description),
		};
	}
	
	$tpl->param(
		ITINS => \@itins,
		RTOURS => \@rtours,
		CITIES => \@cities,
		HOTELS => \@hotels,
		ADTEXT1 => OdysseyDB::WebText->retrieve(web_id => 22)->writeup,
		ADTEXT2 => OdysseyDB::WebText->retrieve(web_id => 34)->writeup,
	);

	return $tpl->output;
}

sub quotes {
	
	my $app = shift;
	my $from = $app->query->param('from');
	

	my $username = $app->session->param('username');
	if (! $username) {
		my $tpl = $app->load_tmpl('register.tpl', die_on_bad_params => 0);

		$tpl->param(
			RIGHTTEXT => addptags(OdysseyDB::WebText->retrieve(web_id => 29)->writeup),
			LEFTTEXT => addptags(OdysseyDB::WebText->retrieve(web_id => 30)->writeup . '<br />
				<a href="index.cgi?mode=links&id=16">Click here</a> to view our Privacy Policy'),
		);
		return $tpl->output;
	}

	my $tpl = $app->load_tmpl('quotes.tpl', die_on_bad_params => 0);

	my $favs;
	my @quotes;

	my $sth = $app->dbh->prepare("select id, type, addedon from favourites where username = '$username' order by type, addedon");
	$sth->execute;
	
	while (my $row = $sth->fetchrow_hashref('NAME_lc')) {
		push @{$favs->{$row->{type}}}, {
			id => $row->{id}, 
			addedon => $row->{addedon}
		}; 
	}

	my @itins;
	foreach (@{$favs->{itin}}) {
		my $itin = OdysseyDB::Itineraries->retrieve(fixeditin_id => $_->{id});
		push @itins, {
			ID => $_->{id},
			NAME => $itin->title,
			DESC => $itin->oneliner,
			URL => $itin->url,
		} unless $itin->readytours;
	}
	
	my @rtours;
	foreach (@{$favs->{itin}}) {
		my $rtour = OdysseyDB::Itineraries->retrieve(fixeditin_id => $_->{id});
		push @rtours, {
			ID => $_->{id},
			NAME => $rtour->title,
			DESC => $rtour->oneliner,
			URL => $rtour->url,
		} if $rtour->readytours;
	}

	my @cities;
	foreach (@{$favs->{city}}) {
		my $city = OdysseyDB::City->retrieve(cities_id => $_->{id});
		push @cities, {
			ID => $_->{id},
			NAME => $city->city,
			DESC => $city->oneliner,
			URL => $city->url,
		};
	}

	my @hotels;
	foreach (@{$favs->{hotel}}) {
		my $hotel = OdysseyDB::Hotel->retrieve(addressbook_id => $_->{id});
		push @hotels, {
			ID => $_->{id},
			NAME => $hotel->organisation,
			DESC => $hotel->webwriteup1,
			URL => $hotel->url,
		};
	}
	
	$tpl->param(
		ITINS => \@itins,
		RTOURS => \@rtours,
		CITIES => \@cities,
		HOTELS => \@hotels,
	);

	$sth = $app->dbh->prepare("select id, addedon from favourites where username = '$username' and type = 'itin' order by addedon desc");
	$sth->execute;
	
	while (my $row = $sth->fetchrow_hashref('NAME_lc')) {
		push @quotes, {
			id => $row->{id}, 
			addedon => $row->{addedon}
		}; 
	}

	my @qitins;
	foreach (@quotes) {
		my $itin = OdysseyDB::Itineraries->retrieve(fixeditin_id => $_->{id});
		push @qitins, {
			ID => $_->{id},
			NAME => $itin->title,
			DURATION => $itin->duration,
			COST => $itin->prices,
		} unless $itin->readytours;
	}
	
	my @qrtours;
	foreach (@quotes) {
		my $rtour = OdysseyDB::Itineraries->retrieve(fixeditin_id => $_->{id});
		push @qrtours, {
			ID => $_->{id},
			NAME => $rtour->title,
			DURATION => $rtour->duration,
			COST => $rtour->prices,
		} if $rtour->readytours;
	}

	$tpl->param(
		ITINBASKET => \@qitins,
		RTOURBASKET => \@qrtours,
		FROMTOUR => ($from eq 'Tour') ? 1 : 0,		
	);
	
	return $tpl->output;
}

sub quotation_details {
	my $app= shift;

	my $favs;
	my @quotes;

	my $tpl = $app->load_tmpl('quotation_details.tpl', die_on_bad_params => 0,);
	
	if (my $username = $app->session->param('username')) {

		my $sth = $app->dbh->prepare("select id, type, addedon from favourites where username = '$username' order by type, addedon");
		$sth->execute;
		
		while (my $row = $sth->fetchrow_hashref('NAME_lc')) {
			push @{$favs->{$row->{type}}}, {
				id => $row->{id}, 
				addedon => $row->{addedon}
			}; 
		}

		my @itins;
		foreach (@{$favs->{itin}}) {
			my $itin = OdysseyDB::Itineraries->retrieve(fixeditin_id => $_->{id});
			push @itins, {
				ID => $_->{id},
				NAME => $itin->title,
				DESC => $itin->oneliner,
				URL => $itin->url,
			} unless $itin->readytours;
		}
		
		my @rtours;
		foreach (@{$favs->{itin}}) {
			my $rtour = OdysseyDB::Itineraries->retrieve(fixeditin_id => $_->{id});
			push @rtours, {
				ID => $_->{id},
				NAME => $rtour->title,
				DESC => $rtour->oneliner,
				URL => $rtour->url,
			} if $rtour->readytours;
		}

		my @cities;
		foreach (@{$favs->{city}}) {
			my $city = OdysseyDB::City->retrieve(cities_id => $_->{id});
			push @cities, {
				ID => $_->{id},
				NAME => $city->city,
				DESC => $city->oneliner,
				URL => $city->url,
			};
		}

		my @hotels;
		foreach (@{$favs->{hotel}}) {
			my $hotel = OdysseyDB::Hotel->retrieve(addressbook_id => $_->{id});
			push @hotels, {
				ID => $_->{id},
				NAME => $hotel->organisation,
				DESC => $hotel->webwriteup1,
				URL => $hotel->url,
			};
		}
		
		$tpl->param(
			ITINS => \@itins,
			RTOURS => \@rtours,
			CITIES => \@cities,
			HOTELS => \@hotels,
		);
	}
	
	my @modules = $app->query->param('modules');
	my @readytours = $app->query->param('readytours');
	my $request = $app->query->param('sprequest');

	my @items = map {{
		ITEMID => $_,
		ITEMNAME => OdysseyDB::Itineraries->retrieve(fixeditin_id => $_)->title,
	}} (@modules, @readytours);
	
	$tpl->param(
		ITEMS => \@items,
		REQUEST => $request,
	);
	
	return $tpl->output;
}


sub quote_modtours {
	my $app = shift;
	my $q = $app->query;
	
	my @items = $q->param('items');
	my $request = $q->param('request');
	
	my $leadname = $q->param('leadname');

	if (my $username = $app->session->param('username')) {

		my $sthfav = $app->dbh->prepare("delete from favourites where id = ? and username = '$username'");
		my $sthquote = $app->dbh->prepare("delete from quotes where id = ? and username = '$username'");

		my @itins;

		foreach (@items) {
			$sthfav->execute($_);
			$sthquote->execute($_);

			my $itin = OdysseyDB::Itineraries->retrieve(fixeditin_id => $_);

			push @itins, {
				ITINID => $_,
				ITINNAME => $itin->title,
				ITINDESC => $itin->oneliner,
				ITINURL => $itin->url,
			};
		}
		
		my $emailtpl = $app->load_tmpl('email_quote_modtours.tpl', die_on_bad_params => 0);

		$emailtpl->param(
			LEADNAME => $leadname,
			LEADEMAIL => $username,
			ITINS => \@itins,
			REQUEST => $request,
		);

#		CC => 'hans@odyssey.co.in',

		my $msg = MIME::Lite->new(
			To => $username,
			From => 'Travellers Palm Administrator <admin@odyssey.co.in>',
			Subject => 'Your Request for a Quote',
			Type => 'multipart/related',
		);
	
		$msg->attach(
			Type => 'text/html',
			Data => $emailtpl->output,
		);

		MIME::Lite->send(
			'smtp', 
			'travellers-palm.com', 
			Timeout => 30,
			AuthUser => 'admin@travellers-palm.com',
			AuthPass => 'ip31415',
			Debug => 1,
		);
	
		$msg->send;
	
		my $tpl = $app->load_tmpl('quote_thanks.tpl', die_on_bad_params => 0);
		return $tpl->output;
	}
	else {
		die({type => 'error', msg => 'You are not a valid user'});
	}
}

sub itincost {
	
	my $app = shift;
	my $itinid = shift;
	my $currency = shift;
	
	my $qry = "
		select
			cost
		from
			fixeditincosts,
			currencies
		where
			fixeditin_id = ? and
			principalagents_id = 68 and
			frompax = 2 and
			topax = 2 and
			fixeditincosts.currencies_id = currencies.currencies_id and
			currencies.currencycode = ?
		order by
			wef desc
	";
	my $dbh = OdysseyDB::City->db_Main();
	my $sth = $dbh->prepare($qry);
	
	$sth->execute($itinid, $currency);
	
	my ($cost) = $sth->fetchrow_array;
	
	return int($cost) . ' ' . $currency;
}

sub firstpara {
	my $str = shift;
	$str = addptags($str);
	$str =~ /^\<p class=\"writeup\"\>(.*?)\<\/p\>/;
	return $1;
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

1;
