package Odyssey::Tours;

use strict;
use warnings;

use lib qw{../};

use base qw(Odyssey);

use OdysseyDB::Itineraries;
use OdysseyDB::WebText;
use OdysseyDB::WebPage;

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
		tours_index => 'tours_index',
		main =>	'main',
		describe => 'describe',
	);

	$app->start_mode('tours_index');
	$app->error_mode('errhndlr');

}

sub tours_index {
	my $app = shift;
	my $tpl = $app->load_tmpl('tours_index.tpl', die_on_bad_params => 0, global_vars => 1);
	
	my $tourstext = OdysseyDB::WebText->retrieve(web_id => 57)->writeup;
	my $metatext = OdysseyDB::WebPage->retrieve(webpages_id => 22);

	$tpl->param(
		METADESCRIPTION => $metatext->metatype,
		METAKEYWORDS => $metatext->keywords,
		PAGETITLE => $metatext->descr,
		TOURSTEXT => addptags($tourstext),
	);

	my $uri = URI->new($app->query->url(-base => 1));
	my $tld = ($uri->host =~ /(.*)\.(.*)/) ? $2 : 'com';
	my $currency = (exists $currencies->{$tld}) ? $currencies->{$tld} : 'USD';
	
	my @tours;
	foreach (OdysseyDB::Itineraries->search(readytours => 1, {order_by => 'orderno'})) {
		next if $_->inactivewef;
		my $itinid = $_->fixeditin_id;
		push @tours, {
			TOURID => $itinid,
			TOURNAME => $_->title,
			TOURONELINER => $_->oneliner,
			TOURINTRO => $_->adv,
			TOURPRICE => 'From ' . $app->itincost($itinid, $currency) . ' per person - based on 2 people sharing',
			TOURDURATION => $_->duration,
			TOURDATES => $_->itindates,
			TOURINCLUDES => $_->inclusions,
			TOURURL => $_->url,
		};
	}

	my $tourcount = @tours;
	my $pagecount;
	
	{
		use integer;
		$pagecount = $tourcount / 2;
	}
	
	my $page = $app->param('page') || 1;
	if ($page == '1') {
		@tours = @tours[0..$pagecount-1];
	}
	elsif ($page == '2'){
		@tours = @tours[$pagecount..$tourcount-1];
	}
	else {
		die("Unknown Page Request")
	}
	
	
	my $sidetext = OdysseyDB::WebText->retrieve(web_id => 11);
	
	$tpl->param(
		TOURCOUNT => $tourcount,
		PAGECOUNT => $pagecount,
		PAGECOUNTPLUSONE => $pagecount + 1,
		SIDETITLE => $sidetext->title,
		SIDETEXT => addptags($sidetext->writeup),
		FIRSTPAGE => ($page eq '1'),
		TOURS => \@tours,
	);
	return $tpl->output;
}

sub main {
	use Data::Dumper;
	
	my $app = shift;
	
	my $tpl = $app->load_tmpl('tours.tpl', die_on_bad_params => 0, global_vars => 1);
	
	my @tours;
	foreach (OdysseyDB::Itineraries->search(readytours => 1, {order_by => 'orderno'})) {
		next if $_->inactivewef;
		push @tours, {
			TOURID => $_->fixeditin_id,
			TOURNAME => $_->title,
			TOURONELINER => $_->oneliner,
			TOURINTRO => $_->adv,
			TOURPRICE => $_->prices,
			TOURDURATION => $_->duration,
			TOURDATES => $_->itindates,
			TOURINCLUDES => $_->inclusions,
			TOURURL => $_->url,
		};
	}

	my $tourcount = @tours;
	my $pagecount;
	
	{
		use integer;
		$pagecount = $tourcount / 2;
	}
	
	my $page = $app->param('page');
	if ($page == '1') {
		@tours = @tours[0..$pagecount-1];
	}
	elsif ($page == '2'){
		@tours = @tours[$pagecount..$tourcount-1];
	}
	else {
		die("Unknown Page Request")
	}
	
	
	my $sidetext = OdysseyDB::WebText->retrieve(web_id => 11);
	
	my $webpage = OdysseyDB::WebPage->retrieve(webpages_id => 22);

	$tpl->param(
		METADESCRIPTION => $webpage->metatype,
		METAKEYWORDS => $webpage->keywords,
		PAGETITLE => $webpage->descr,
		TOURCOUNT => $tourcount,
		PAGECOUNT => $pagecount,
		PAGECOUNTPLUSONE => $pagecount + 1,
		SIDETITLE => $sidetext->title,
		SIDETEXT => addptags($sidetext->writeup),
		FIRSTPAGE => ($page eq '1'),
		TOURS => \@tours,
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

sub linkify {
	
	my $str = shift;
	my $sid = shift;
#	return $str;
	my $lstr = '';

	while ( $str =~ /(.*?)\[(.*?)\](.*)/sm ) {
		my ($name, $id) = split(/\-/, $2);
		$lstr = $lstr . $1 . " <a href=\"hotel.cgi?mode=minidescribe&id=$id&height=500&width=420\" title=\"Hotels\" class=\"thickbox\">$name</a>";
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
1;
