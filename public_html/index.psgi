use lib qw{../traveljadoo/lib/};

use strict;
use warnings;

use Plack::Builder;
use CGI::Application::Dispatch::PSGI;
use Plack::App::WrapCGI;


use Odyssey::Constants;

my $app = CGI::Application::Dispatch::PSGI->as_psgi(
    prefix => 'Odyssey',
    args_to_new => {
        cfg_file => $Odyssey::Constants::confdir . 'Odyssey.conf',
    },
    table => [
        ''                                      => {app => 'Init', rm => 'home'},
        '/'                                     => {app => 'Init', rm => 'home'},
        'about-us'                              => {app => 'Init', rm => 'about'},
        'acknowledge-quotation'                 => {app => 'Init', rm => 'quote_modtours'},
        'add-to-favourites'                     => {app => 'Init', rm => 'protected_save_favourites'},
        'before-you-go'                         => {app => 'Init', rm => 'links', text => 17},
        'booking-conditions'                    => {app => 'Init', rm => 'legal', text => 15},
        'checkout'                              => {app => 'Payment', rm => 'index'},
        'city/:city'                            => {app => 'Hotels', rm => 'cityhotels'},
        'confirm-quotation'                     => {app => 'Init', rm => 'quotation_details'},
        'contact-us'                            => {app => 'Init', rm => 'contact'},
        'failure'                               => {app => 'Payment', rm => 'failure'},
        'form'                                  => {app => 'Init', rm => 'init'},
        'getimg_attr/:imgname'                  => {app => 'Hotels', rm => 'getimg_attr'},
        'heritage-hotels'                       => {app => 'Hotels', rm => 'heritagehotels'},
        'home-stays'                            => {app => 'Hotels', rm => 'homestays'},
        'hotel-categories'                      => {app => 'Hotels', rm => 'hoteltypes'},
        'hotel/:hotel'                          => {app => 'Hotels', rm => 'describe'},
        'hotelcatsbox'                          => {app => 'Hotels', rm => 'minihoteltypes', height => 500, width => 400},
        'how-to-plan-your-trip'                 => {app => 'Init', rm => 'links', text => 73, webpage => 45},
        'meet-the-team'                         => {app => 'Init', rm => 'people'},
        'moduledetails/:tour'                   => {app => 'Itineraries', rm => 'describe'},
        'modules'                               => {app => 'Region', rm => 'main'},
        'modules/:module'                       => {app => 'Itineraries', rm => 'region'},
        'modules/list'                          => {app => 'Region', rm => 'list'},
        'my-travellers-palm'                    => {app => 'Init', rm => 'quotes'},
        'myfavourites'                          => {app => 'Itineraries', rm => 'favourites'},
        'privacy-policy'                        => {app => 'Init', rm => 'legal', text => 16},
        'request-a-quote'                       => {app => 'Itineraries', rm => 'quotes'},
        'responsible-travel'                    => {app => 'Init', rm => 'links', text => 13, webpage => 46},
        'save_quote'                            => {app => 'Payment', rm => 'save_quote'},
        'search'                                => {app => 'Hotels', rm => 'namesearch'},
        'send_quote'                            => {app => 'Payment', rm => 'send_quote'},
        'show_quote/:qid/:uuid/:digest'         => {app => 'Payment', rm => 'show_quote'},
        'special_places'                        => {app => 'Hotels', rm => 'index'},
        'state/:state'                          => {app => 'Hotels', rm => 'statehotels'},
        'success'                               => {app => 'Payment', rm => 'success'},
        'terms-of-use'                          => {app => 'Init', rm => 'legal', text => 35},
        'thanks/:qid/:puuid/:digest'            => {app => 'Payment', rm => 'thanks'},
        'themes'                                => {app => 'Themes', rm => 'main'},
        'themes/:theme'                         => {app => 'Themes', rm => 'describe'},
        'themes/:theme/:subthemeid'             => {app => 'Themes', rm => 'get_subthemecities'},
        'themes/:theme/:subthemeid/:cityid'     => {app => 'Themes', rm => 'get_citydesc'},
        'togateway'                             => {app => 'Payment', rm => 'togateway'},
        'tourdetails/:tour'                     => {app => 'Itineraries', rm => 'describe'},
        'tours/:page?'                          => {app => 'Tours', rm => 'tours_index'},
        'upload_quote'                          => {app => 'Payment', rm => 'upload_quote'},
        'what-to-expect'                        => {app => 'Init', rm => 'links', text => 21, webpage => 44},
        'why-travel-with-us'                    => {app => 'Init', rm => 'links', text => 12, webpage => 43},
    ],
    debug => 1,
);

my $main_app = builder {
    enable "Plack::Middleware::Static",
        path => qr{^/(images/|js/|css/|markers/|maps/|test\.swf|Odyssey_Before_You_Go\.pdf|favicon.ico|robots.txt)}, root => './';
    $app;   
};

my $popup_app = Plack::App::WrapCGI->new(
	script => "hotel.cgi", 
)->to_app;

my $currency_app = Plack::App::WrapCGI->new(
        script => "currency.cgi",
)->to_app;

my $user_app = Plack::App::WrapCGI->new(
	script => "old_index.cgi", 
)->to_app;

my $srf_rail = Plack::App::WrapCGI->new(
	script => 'rail.cgi',
)->to_app;

my $srf_flights = Plack::App::WrapCGI->new(
	script => 'flights.cgi',
)->to_app;

my $srf_routefinder = Plack::App::WrapCGI->new(
	script => 'routefinder.cgi',
)->to_app;

builder {
	mount "/"                => $main_app;
	mount "/hotel.cgi"       => $popup_app;
        mount "/currency.cgi"    => $currency_app;
	mount '/rail.cgi'        => $srf_rail;
	mount '/flights.cgi'     => $srf_flights;
	mount '/routefinder.cgi' => $srf_routefinder;
	mount "/old_index.cgi"   => $user_app;
}
