package Odyssey::Currency;

use strict;
use warnings;

use lib qw{../};

use base qw(Odyssey);

use OdysseyDB::Currency;

our $VERSION = '0.01';

# Preloaded methods go here.

sub setup {
	my $app = shift;

	$app->mode_param('mode');	

	$app->run_modes(
             	index => 'index',
 		list => 'list',
	);

        $app->start_mode('index');
	$app->error_mode('errhndlr');
}

sub index {
	my $app = shift;
        my $tpl = $app->load_tmpl('currency.tpl', die_on_bad_params => 0, global_vars => 1);

	my @currencies;
        foreach (OdysseyDB::Currency->retrieve_all) {
             if ($_->hdfccode) {
                push @currencies, {
                        CODE => $_->currencycode,
                        SYMBOL => $_->symbol,
                        CURRENCY => $_->currency,
                }};
        }

	$tpl->param({
                CURRENCIES => \@currencies,
		URI => $ENV{'HTTP_REFERER'},
        });

        return $tpl->output;

}

sub list {
	
        my $app = shift;
   	my $tpl = $app->load_tmpl('currency.tpl', die_on_bad_params => 0, global_vars => 1);

        my @currencies;
        foreach (OdysseyDB::Currency->retrieve_all) {
                if ($_->hdfccode) {
                push @currencies, {
                        CURRENCY => $_->currency,
                        SYMBOL => $_->symbol,
                        CODE => $_->currencycode,
                }};
        }

        $tpl->param({
                CURRENCIES => \@currencies,
                URI => $ENV{'HTTP_REFERER'},
        });

        return $tpl->output;

}

1;
