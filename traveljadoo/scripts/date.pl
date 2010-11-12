#!/usr/bin/perl

use strict;
use warnings;

use Date::Manip;

my $daycal = "Dec 21 09";
my $ii = 42;

print "Here: " . UnixDate(DateCalc($daycal, "$ii days"), "%b %d %y") . "\n";

exit;
