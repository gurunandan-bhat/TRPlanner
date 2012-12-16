#!/usr/bin/env perl

use strict;
use warnings;

use feature qw{say};
use lib qw{../lib};

use OdysseyDB::WebText;

foreach (my @rows = OdysseyDB::WebText->retrieve_all) {
	
	say $_->web_id . "\t" . ($_->writeup || 'Blank Line');
}

