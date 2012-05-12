package Odyssey::Amend;

use strict;
use warnings;

use lib qw{/home3/travelja/myperl/lib /home3/travelja/traveljadoo/lib};
use lib qw{../};

use base qw(Odyssey);

use OdysseyDB::City;
use OdysseyDB::Hotel;
use OdysseyDB::QuotationCity;
use OdysseyDB::Quotation;
use OdysseyDB::QuotationTicket;
use Date::Manip;
use Date::Calc qw(Delta_Days);

our $VERSION = '0.01';

# Preloaded methods go here.

sub setup {
	my $app = shift;
	
	$app->mode_param('mode');

	$app->run_modes(
		listquotes => 'listquotes',
		listtour => 'listtour',
	);

	$app->start_mode('listquotes');
	$app->error_mode('errhndlr');
}

sub listquotes {
	
	my $app = shift;
	my $tpl = $app->load_tmpl('listquotes.tpl', die_on_bad_params => 0, loop_context_vars => 1);
	
	my @quotations = OdysseyDB::Quotation->retrieve_from_sql(qq{
		web = 1 AND
		trial = 1
		order by quotations_id desc
	});
	
	
	my @tours;
	my $maxrows = 15;
	my $rownum = 1;
	for (@quotations) {

		my $t;
		push @tours, {
			QUOTEID => $_->quotations_id,
			PAXNAME => $_->paxname,
			ARRDATE => ($t = $_->dateofarrival) ? UnixDate($t, '%d %b, %Y') : undef,
			STARTDATE => ($t = $_->startdate) ? UnixDate($t, '%d %b, %Y') : undef,
		};

		last if ($rownum++ >= $maxrows);
	}	
	
	
	$tpl->param(QUOTES => \@tours);
	return $tpl->output;
}

