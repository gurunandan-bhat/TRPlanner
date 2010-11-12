#!/usr/bin/perl

use strict;
use warnings;

use Date::Manip;
use Date::Calc qw(Delta_Days);

print _get_days_between('Oct 27 2009', 'Oct 31 2010');

sub _get_days_between {
	my $datein = shift;
	my $dateout = shift;
	my ($yearin, $monthin, $dayin) = split /\s+/, UnixDate($datein, "%Y %f %e");
	my ($yearout, $monthout, $dayout) = split /\s+/, UnixDate($dateout, "%Y %f %e");
	return Delta_Days($yearin, $monthin, $dayin, $yearout, $monthout, $dayout);
}
