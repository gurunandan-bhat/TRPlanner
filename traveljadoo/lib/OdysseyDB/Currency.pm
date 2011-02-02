package OdysseyDB::Currency;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('currencies');

__PACKAGE__->columns(Primary => 'currencies_id');
__PACKAGE__->columns(Others => qw{
	currencycode
	currency
	symbol
	countries_id
	hdfccode
	terminalid
	merchantid	
});

1;
