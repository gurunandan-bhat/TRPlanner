package Odyssey::Region;

use strict;
use warnings;

use lib qw{../};

use base qw(Odyssey);

use OdysseyDB::Region;
use OdysseyDB::WebText;
use OdysseyDB::WebPage;

our $VERSION = '0.01';

# Preloaded methods go here.

sub setup {
	my $app = shift;
	
	$app->run_modes(
		main =>	'main',
		describe => 'describe',
		login => 'login',
		logout => 'logout',
		list => 'list',
	);

	$app->start_mode('main');
	$app->error_mode('errhndlr');
}

sub main {
	my $app = shift;
	
	my $tpl = $app->load_tmpl('region.tpl', die_on_bad_params => 0);
	my $content = OdysseyDB::WebText->retrieve(web_id => 7);
	
	my $webpage = OdysseyDB::WebPage->retrieve(webpages_id => 11);

	my @allregions = OdysseyDB::Region->retrieve_all;
	 
	my @urls = map {
		"'" . $_->url . "'",
	} @allregions;
	
	my @regions = map{{
		REGIONID => $_->regions_id,
		REGIONNAME => $_->title,
		REGIONDESC => $_->introduction,
		REGIONURL => $_->url,
	}} @allregions;


	my @top10 = map {
		my $top10 = OdysseyDB::WebText->retrieve(web_id => $_);
		{
			T10ID => $_,
			T10TITLE => $top10->title,
			T10TEXT => $top10->writeup,
		};
	} (85 .. 94);
	
	$tpl->param(
		METADESCRIPTION => $webpage->metatype,
		METAKEYWORDS => $webpage->keywords,
		PAGETITLE => $webpage->descr,
		TITLE => $content->title,
		WRITEUP => boldify(addptags($content->writeup)),
		REGIONS => \@regions,
		REGIONURLS => join(', ', @urls),
		TOP10 => \@top10,
		SIDETITLE => OdysseyDB::WebPage->retrieve(webpages_id => 42)->pagename,
	);
	
	return $tpl->output;
}

sub list {
	
	my @modulenames = map {$_->url} OdysseyDB::Region->retrieve_all;
	
	my $count = @modulenames;
	
	my $json = {
		count => $count,
		modules => \@modulenames,
	};
	
	return JSON->new->utf8(1)->encode($json);
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
	
	$str =~ s/\{/\<strong\>/gm;
	$str =~ s/\}/\<\/strong\>/gm;
	
	return $str;
}


1;
