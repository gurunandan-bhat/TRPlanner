package Odyssey::Sessions;

use strict;
use warnings;

use lib qw{../};

use base qw(Odyssey);

use CGI qw(:standard);
use WWW::ipinfo;

our $VERSION = '0.01';

# Preloaded methods go here.

sub cookie {

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

	my $cookie = $cgi->cookie('Currency');
	if (!$cookie) {
		my $ipinfo = get_ipinfo();
	        $country = $ipinfo->{country};
	  	my $currency = (exists $currencies->{$country}) ? $currencies->{$country} : 'USD';

		my $cgi = new CGI;
	        my $cookie = $cgi->cookie( -name => 'Currency', -value => $currency, -expires => '+1h' );
	};
};   

1;
