package RailDB::Fares;

use strict;
use warnings;

use lib qw{../};

use base qw(RailDB);

our $VERSION = '0.01';

__PACKAGE__->table('zz_fares');

__PACKAGE__->columns(Primary => 'id');
__PACKAGE__->columns(Others => qw{
	trnnum
	source
	destn
	class
	basefare
	resfare
	sfstfare
	othrfare
	ttklfare
	addlrfare
});
	
1;
__END__
