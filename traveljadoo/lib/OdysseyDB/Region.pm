package OdysseyDB::Region;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);
use Class::DBI::Plugin::RetrieveAll;


__PACKAGE__->table('regions');

__PACKAGE__->columns(Primary => 'regions_id');
__PACKAGE__->columns(Others => qw{
	title
	oneliner
	introduction
	region
	url
});

__PACKAGE__->has_many(itineraries => 'OdysseyDB::Itineraries', {order_by => 'orderno'});
__PACKAGE__->retrieve_all_sort_field('regions_id');

1;
