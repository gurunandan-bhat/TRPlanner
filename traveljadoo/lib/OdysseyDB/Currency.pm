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

__PACKAGE__->set_sql(hdfc => qq{
   	select 		* 
   	from 		currencies 
	where 		hdfccode is true 
	order by 	currency
});

1;
