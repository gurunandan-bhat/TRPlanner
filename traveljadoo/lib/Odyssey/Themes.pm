package Odyssey::Themes;

use strict;
use warnings;

use lib qw{../};

use JSON;

use base qw(Odyssey);

use OdysseyDB::State;
use OdysseyDB::City;
use OdysseyDB::Theme;
use OdysseyDB::SubTheme;
use OdysseyDB::SubThemeCities;
use OdysseyDB::WebText;
use OdysseyDB::WebPage;

use Data::Dumper;

our $VERSION = '0.01';

# Preloaded methods go here.

sub setup {
	my $app = shift;
	
	$app->mode_param('mode');

	$app->run_modes(
		main =>	'main',
		describe => 'describe',
		get_subthemecities => 'get_subthemecities',
		get_citydesc => 'get_citydesc',
		login => 'login',
		logout => 'logout',
	);

	$app->start_mode('main');
	$app->error_mode('errhndlr');
}

sub main {
	my $app = shift;
	
	my @themes = map {{
		THEME_ID => $_->themes_id,
		THEME_TITLE => $_->title,
		THEME_INTRO => $_->introduction,
		THEME_URL => $_->url,
	}} OdysseyDB::Theme->retrieve_all;
	
	my @toprow = @themes[0..2];
	my @botrow = @themes[3..5];
	
	my $tpl = $app->load_tmpl('theme_index.tpl', die_on_bad_params => 0, loop_context_vars => 1);

	my $webpage = OdysseyDB::WebPage->retrieve(webpages_id => 21);
	
	$tpl->param(
		METADESCRIPTION => $webpage->metatype,
		METAKEYWORDS => $webpage->keywords,
		PAGETITLE => $webpage->descr,
		WRITEUP => OdysseyDB::WebText->retrieve(web_id => 6)->writeup,
		TOPROW => \@toprow,
		BOTROW => \@botrow,
	);
	
	return $tpl->output;
}

sub describe {

	my $app = shift;
	my $url = $app->param('theme');
	
	die({type => 'error', msg => 'No Theme available. Aborting!'}) unless (my @sthemes = OdysseyDB::Theme->search(url => $url)); 

	my $theme = $sthemes[0];
	my $themeid = $theme->themes_id;
	
	my @themes = map {{
		THEME_ID => $_->themes_id,
		THEME_TITLE => $_->title,
		THEME_INTRO => $_->introduction,
		THEME_CURRENT => ($_->themes_id == $themeid) ? 'current' : undef,
		THEME_URL => $_->url,
	}} OdysseyDB::Theme->retrieve_all;

	my @subthemes = map {{
		SUBTHEME_ID => $_->subthemes_id,
		SUBTHEME_NAME => $_->title,
		SUBTHEME_INTRO => $_->subtheme,
		SUBTHEME_URL => $url . '/' . $_->url,
	}} $theme->subthemes;
	
	my $tpl = $app->load_tmpl('theme_describe.tpl', die_on_bad_params => 0);
	
	$tpl->param(
		METADESCRIPTION => $theme->metatype,
		METAKEYWORDS => $theme->keywords,
		PAGETITLE => $theme->descr,
		THEME => $theme->title,
		THEMEINTRO => addptags($theme->introduction),
		MAINTHEMES => \@themes,
		SUBTHEMES =>\@subthemes,
	);
	
	return $tpl->output;
}


sub get_subthemecities {
	
	my $app = shift;
	my $subthemeid = $app->param('subthemeid');
	
	my $subtheme = OdysseyDB::SubTheme->retrieve(subthemes_id => $subthemeid);
	
	my @mapcities = map {{
		id => $_->cities_id,
		name => $_->city,
		lat => $_->latitude,
		lng => $_->longitude,
		desc => $_->writeup
	}} $subtheme->cities;
	
	my $res = {
		subthemename => $subtheme->title,
		subthemedesc => addptags($subtheme->introduction),
		mapcities => \@mapcities,
	};
	
	return JSON->new->utf8(1)->encode($res);
}

sub get_citydesc {
	
	my $app = shift;

	my $subthemeid = $app->param('subthemeid');
	my $cityid = $app->param('cityid');

	my $tpl = $app->load_tmpl('themecity_desc.tpl', die_on_bad_params => 0);

	my @res = OdysseyDB::SubThemeCities->search(subthemes_id => $subthemeid, cities_id => $cityid);
	
	$tpl->param(
		CITYID => $res[0]->cities_id->cities_id,
		CITYSTATEID => $res[0]->cities_id->states_id,
		CITYNAME => $res[0]->cities_id->city,
		CITYDESC => $res[0]->citysubtheme,
		CITYURL => $res[0]->cities_id->url,
	);
	
	return $tpl->output;
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


1;
