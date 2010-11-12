#! /usr/bin/perl

use strict;
use warnings;

use lib qw{../traveljadoo/lib/};

use Odyssey::Itinerary;
use Odyssey::Constants;

my $app = Odyssey::Itinerary->new({
	cfg_file => $Odyssey::Constants::confdir . 'Odyssey.conf',
});

$app->run();


# Different issues were encountered while using DBD::Sybase in an 
# environment that uses lazy loading of Database handles (CAP::DBH).
# DBD::Sybase has a broken (?) ping. and gives a warning about 
# CS_TEXT_OPTSIZE not being set. 

# The broken ping was fixed by following instructuctions at
# http://www.peppler.org/bugdb/view?bug_id=633. The CS_TEXT_OPTSIZE
# warning is fixed by following this: http://www.peppler.org/bugdb/view?bug_id=609

# Requires the following setting in the httpd conf file:


# PerlModule ModPerl::RegistryPrefork
# PerlModule Apache::DBI
# Alias /odyssey /home/guru/workspace/Odyssey/webroot
# <Directory /home/guru/workspace/Odyssey/webroot>
# <FilesMatch "\.cgi$">
# 	  SetHandler		perl-script
# 	  PerlResponseHandler	ModPerl::RegistryPrefork
#	  PerlOptions		+ParseHeaders
#	  Options 		+ExecCGI
#	  Order			allow,deny
#	  Allow			from all
# </FilesMatch>
# </Directory>
