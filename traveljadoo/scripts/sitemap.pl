#!/usr/bin/perl

use strict;
use warnings;

use lib qw{../lib};

use OdysseyDB::State;
use OdysseyDB::City;
use OdysseyDB::Hotel;
use OdysseyDB::Theme;
use OdysseyDB::Region;
use OdysseyDB::Itineraries;

use Search::Sitemap;

# Sections Generated:
# Cities
# Hotels
# States
# Themes
# Itineraries
# Main Menu Links


my $odyssey = Search::Sitemap->new();
$odyssey->pretty(1);

# Generating Top Level Links

$odyssey->add(
	loc => q{http://www.travellers-palm.com},
	priority => 1,
	changefreq => 'monthly',
);

$odyssey->add(
	loc => q{http://www.travellers-palm.com/themes},
	priority => 1,
	changefreq => 'monthly',
);

$odyssey->add(
	loc => q{http://www.travellers-palm.com/special_places},
	priority => 1,
	changefreq => 'monthly',
);

$odyssey->add(
	loc => q{http://www.travellers-palm.com/modules},
	priority => 1,
	changefreq => 'monthly',
);

$odyssey->add(
	loc => q{http://www.travellers-palm.com/tours},
	priority => 1,
	changefreq => 'monthly',
);

$odyssey->add(
	loc => q{http://www.travellers-palm.com/about-us},
	priority => 1,
	changefreq => 'monthly',
);


$odyssey->add(
	loc => q{http://www.travellers-palm.com/contact-us},
	priority => 1,
	changefreq => 'monthly',
);

# Generating States Links
# Link Template: http://www.travellers-palm.com/hotel.cgi?mode=statehotels&sid=<STATEID>&state=1

foreach (OdysseyDB::State->search(countries_id => 200)) {

	my $surl = $_->url;

	$odyssey->add(
		loc => qq{http://www.travellers-palm.com/state/$surl},
		changefreq => 'weekly',
		priority => 0.8,
	);
	print "$surl\n";
}

# Generating Cities and Hotel Links
# City Link Template: http://www.travellers-palm.com/hotel.cgi?mode=cityhotels&sid=<STATEID>&cid=<CITYID>&city=1

foreach (OdysseyDB::City->search_webhotelcities) {
	
	my $curl = $_->url;
	my $cid = $_->cities_id;
	$odyssey->add(
		loc => qq{http://www.travellers-palm.com/city/$curl},
		changefreq => 'weekly',
		priority => 0.8,
	);
	print "$curl\n";
	
# 	Hotel Link Template: http://www.travellers-palm.com/hotel.cgi?mode=describe&id=<HOTELID>
	foreach (OdysseyDB::Hotel->search_alltypes_bycity($cid)) {
		
		my $hurl = $_->url;
		
		$odyssey->add(
			loc => qq{http://www.travellers-palm.com/hotel/$hurl},
			changefreq => 'weekly',
			priority => 0.8,
		);
		print "$hurl\n";
	}
}

# Generating Themes and Subthemes Links:
# Theme Link Template: http://www.travellers-palm.com/theme.cgi?mode=describe&id=1

foreach (OdysseyDB::Theme->retrieve_all) {
	
	my $turl = $_->url;
	
	$odyssey->add(
		loc => qq{http://www.travellers-palm.com/themes/$turl},
		changefreq => 'weekly',
		priority => 0.8,
	);
	print "$turl\n";
	
}

# Generating Regions Links:
# Region Link Template: http://www.travellers-palm.com/itineraries.cgi?mode=region&id=2

foreach (OdysseyDB::Region->retrieve_all) {
	
	my $rurl = $_->url;
	
	$odyssey->add(
		loc => qq{http://www.travellers-palm.com/modules/$rurl},
		changefreq => 'weekly',
		priority => 0.8,
	);
		print "$rurl\n";
		
	foreach ($_->itineraries) {

		next if $_->inactivewef;
		my $murl = $_->url;

		$odyssey->add(
			loc => qq{http://www.travellers-palm.com/moduledetails/$murl},
			changefreq => 'weekly',
			priority => 0.8,
		);
		print "$murl\n";
	}
}	

# Generating Itinerary Links
# Itinerary Link Template: http://www.travellers-palm.com/itineraries.cgi?mode=describe&id=113

foreach (OdysseyDB::Itineraries->search(readytours => 1, {order_by => 'orderno'})) {
	
	next if $_->inactivewef;
	my $turl = $_->url;

	$odyssey->add(
		loc => qq{http://www.travellers-palm.com/tourdetails/$turl},
		changefreq => 'weekly',
		priority => 0.8,
	);
	print "$turl\n";
}

$odyssey->write('odyssey_sitemap.xml');

exit;
