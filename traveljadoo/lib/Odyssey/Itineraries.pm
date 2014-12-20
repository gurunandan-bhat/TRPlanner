package Odyssey::Itineraries;

use strict;
use warnings;

use lib qw{../};

use base qw(Odyssey);

use OdysseyDB::Itineraries;
use OdysseyDB::Region;
use OdysseyDB::WebText;
use OdysseyDB::WebPage;
#use Odyssey::Sessions('cookie');

use Data::Dumper;

use Date::Manip;
use JSON;
#use URI;
#use CGI qw(:standard);

our $VERSION = '0.01';

# Preloaded methods go here.

my $currencies = {
	au => 'AUD',
	ca => 'CAD',
	es => 'EUR',
	fr => 'EUR',
	ch => 'EUR',
	de => 'EUR',
	it => 'EUR',
	be => 'EUR',
	nl => 'EUR',
	uk => 'GBP',
	in => 'INR',
	nz => 'NZD',
	za => 'ZAR',
};

sub setup {
	my $app = shift;
	
	$app->mode_param('mode');

	$app->run_modes(
		login => 'login',
		logout => 'logout',
		main =>	'main',
		describe => 'describe',
		search => 'search',
		region => 'region',
		namesearch => 'namesearch',
		save_favourites => 'save_favourites',
		protected_save_favourites => 'protected_save_favourites',
		favourites => 'favourites',
		save_quotes => 'save_quotes',
		protected_save_quotes => 'protected_save_quotes',
		quotes => 'quotes',
		quotation_details => 'quotation_details',
		quote_modtours => 'quote_modtours',
	);

	$app->start_mode('main');
	$app->error_mode('errhndlr');
	
}

sub main {
	my $app = shift;
	
	my $tpl = $app->load_tmpl('itineraries.tpl', die_on_bad_params => 0, global_vars => 1);
	
	my @itineraries = map {{
		ITINID => $_->fixeditin_id,
		ITINNAME => $_->title,
		ITINONELINER => $_->oneliner,
		ITINDESC => addptags($_->introduction),
		ITINURL => $_->url,
	}} OdysseyDB::Itineraries->retrieve_all;
	
	$tpl->param(ITINS => \@itineraries);
	
	return $tpl->output;
}

sub region {
	
	my $app = shift;
	my $url = $app->param('module');
	
	my @sregions = OdysseyDB::Region->search(url => $url);
	
	my $region = $sregions[0]->regions_id || 1;

        # my $uri = URI->new($app->query->url(-base => 1));
	# my $tld = ($uri->host =~ /(.*)\.(.*)/) ? $2 : 'com';
        # my $currency = (exists $currencies->{$tld}) ? $currencies->{$tld} : 'USD';
        my $uri_host = $app->query->psgi_header('HTTP_X_FORWARDED_SERVER');
	my $tld = ($uri_host =~ /(.*)\.(.*)/) ? $2 : 'com';
        my $currency = (exists $currencies->{$tld}) ? $currencies->{$tld} : 'USD';

	my @itins;	
	foreach (OdysseyDB::Region->retrieve(regions_id => $region)->itineraries) {
		next if $_->inactivewef;
		my $itinid = $_->fixeditin_id;
		push @itins, {
			ITINID => $itinid,
			ITINNAME => $_->title,
			ITINONELINER => $_->oneliner,
			ITINDESC => $_->adv,
			ITINDURATION => $_->duration,
			ITINPRICE => 'From ' . $app->itincost($itinid, $currency) . ' per person - based on 2 people sharing',
			ITINURL => $_->url,
		};
	}

	my @regs = OdysseyDB::Region->retrieve_all;
	my @regions;
	
	foreach (@regs) {

		next if ($_->regions_id == $region);
		
		push @regions, {
			REGIONID => $_->regions_id,
			REGIONNAME => $_->title,
			REGIONDESC => $_->introduction,
			REGIONURL => $_->url,
		};
	}
	my $tpl = $app->load_tmpl('itineraries.tpl', die_on_bad_params => 0, global_vars => 1);

	my $webpage = OdysseyDB::WebPage->retrieve(webpages_id => 23);
	my $thisregion = OdysseyDB::Region->retrieve(regions_id => $region);
	
	$tpl->param(
		METADESCRIPTION => $webpage->metatype,
		METAKEYWORDS => $webpage->keywords,
		PAGETITLE => $webpage->descr,
		REGIONID => $region,
		REGIONNAME => $thisregion->title,
		REGIONLONGDESC => addptags(strongify($thisregion->region)),
		ITINS => \@itins,
		REGIONS => \@regions,
	);

	return $tpl->output;	
}

sub describe {
	my $app = shift;

	my $itinurl = $app->param('tour') || die({type => 'error', msg => 'No Itinerary ID Found'});
	#
	my @fields = split /;/, $itinurl;
	my ($itinurl, $valuta, $changed) = @fields[0, 1, 2];
	my $test = 'USD';
        # my $ok = cookie();

	my @sitins = OdysseyDB::Itineraries->search(url => $itinurl);
	
	my $itin = $sitins[0];
        if (! defined $itin) {
	     die({type => 'error', msg => "The string '<b>$itinurl</b>' is an invalid tour."})
	};

	my $itinid = $itin->fixeditin_id;
	my $region = $itin->regions_id;
	my @itins = $region ? $region->itineraries : OdysseyDB::Itineraries->search(readytours => 1, {order_by => 'orderno'});
	
	my @otheritins;
	foreach (@itins) {

		next if $_->fixeditin_id == $itinid;
		next if $_->inactivewef;

		push @otheritins, {
			OTHERITINID => $_->fixeditin_id,
			OTHERITINNAME => $_->title,
			OTHERITINURL => $_->url
		};
	}
	
	my $baseprefix = $app->config_param('default.BasePrefix');
	
	my @tips = map {{
		TIPID => $_->fixeditintips_id,
		TIPTITLE => $_->title,
		TIPTEXT => linkify($_->tip, $baseprefix),
	}} $itin->tips;

	my $sidetext = OdysseyDB::WebText->retrieve(web_id => 10);
	
	my $username;
	my $isfav;
	if ($username = $app->session->param('username')) {
		my $sth = $app->dbh->prepare("select count(*) from favourites where username = '$username' and type = 'itin' and id = $itinid");
		$sth->execute;
		($isfav) = $sth->fetchrow_array;
	}
	
	my $isquoted;
	if (my $username = $app->session->param('username')) {
		my $sth = $app->dbh->prepare("select count(*) from quotes where username = '$username' and id = $itinid");
		$sth->execute;
		($isquoted) = $sth->fetchrow_array;
	}
	
	my $tpl = $app->load_tmpl('itinerary.tpl', die_on_bad_params => 0, loop_context_vars => 1, global_vars => 1);

	(my $hilites = $itin->triphighlights) =~ s/\*/\<br \/\>/g;

	my $itintype = $itin->readytours ? 'Tour' : 'Module';
	my $itintypedir = $itin->readytours ? 'tours' : 'modules';
	my $itinlinkimg = $itin->readytours ? 'add-tour-to-fav.gif' : 'add-module-to-fav.gif';
	my $itinquoteimg = $itin->readytours ? 'add-tour-to-basket.gif' : 'add-module-to-basket.gif';
	
	my $itinheaders = OdysseyDB::WebText->retrieve(web_id => 59);
	
        # my $uri = URI->new($app->query->url(-base => 1));
	# my $tld = ($uri->host =~ /(.*)\.(.*)/) ? $2 : 'com';
        # my $currency = (exists $currencies->{$tld}) ? $currencies->{$tld} : 'USD';
        my $uri_host = $app->query->header('HTTP_X_FORWARDED_SERVER');
	my $tld = ($uri_host =~ /(.*)\.(.*)/) ? $2 : 'com';
        my $currency = (exists $currencies->{$tld}) ? $currencies->{$tld} : 'USD';

        print Dumper($app->query);
        
	$tpl->param(
		METADESCRIPTION => $itin->metatype || firstpara($itin->introduction),
		METAKEYWORDS => $itin->keywords || $itin->title,
		PAGETITLE => $itin->descr || undef,
		ITINID => $itinid,
		ITINTYPE => $itin->readytours ? 'rt' : 'mod',
		ITINTYPEDIR => $itintypedir,
		REGIONID => $region ? $region->regions_id : undef,
		REGIONNAME => $region ? $region->title : undef,
		REGIONURL => $region ? $region->url : undef,
		OTHERITINS => \@otheritins,
		NUMIMAGES => $app->itineraryimages($itintypedir, $itinid),
		ITINNAME => $itin->title,
		ITINONELINER => $itin->oneliner,
		ITINDESC => addptags($itin->introduction),
		ITINDETAILS => addptags(boldify(linkify($itin->itinerary, $baseprefix))),
		ITINQUOTE => $itin->quotes,
		ITINHIGHLIGHTS => boldify($hilites),
		ITINISTOUR => $itin->readytours,
		ITINDATES => boldify($itin->itindates),
		ITININCLUSIONS => boldify($itin->inclusions),
		ITINPRICE => 'From ' . $app->itincost($itinid, $currency) . ' per person - based on 2 people sharing',
		ITINTIPSHEADER => $itinheaders->title,
                ITINDURATION => $itin->duration,
		ITINTIPSINTRO => $itinheaders->writeup,
		ITINTIPS => \@tips,
		SIDETITLE => $sidetext->title,
		SIDETEXT => $sidetext->writeup,
		REGISTERED => $username ? 1 : 0,
		ISFAVOURITE => $isfav,
                CURRENCY => $test,
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

sub firstpara {
	my $str = shift;
	$str = addptags($str);
	$str =~ /^\<p class=\"writeup\"\>(.*?)\<\/p\>/;
	return $1;
}

sub linkify {
	
	my $str = shift;
	my $baseprefix = shift;
#	return $str;
	my $lstr = '';

	while ( $str =~ /(.*?)\[(.*?)\](.*)/sm ) {
		my ($name, $id) = split(/\-/, $2);
		$lstr = $lstr . $1 . " <a href=\"" . $baseprefix . "hotel.cgi?mode=minidescribe&id=$id&height=500&width=420\" title=\"Hotels\" class=\"thickbox\">$name</a>";
		$str = $3;
	}
	$lstr = $lstr . $str;
	return $lstr;
}

sub boldify {
	my $str = shift;
	
	$str =~ s/\{/\<h5\>/gm;
	$str =~ s/\}/\<\/h5\>/gm;
	
	return $str;
}

sub strongify {
	my $str = shift;
	
	$str =~ s/\{/\<strong\>/gm;
	$str =~ s/\}/\<\/strong\>/gm;
	
	return $str;
}
1;
