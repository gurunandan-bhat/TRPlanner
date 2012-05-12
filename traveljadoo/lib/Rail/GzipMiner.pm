package Rail::GzipMiner;

use strict;
use warnings;

use lib qw{../};

use Carp;
use Config::Simple;
use DBI;
use LWP;
use HTML::TokeParser;
use HTML::Entities;
use WWW::Mechanize::GZip;
use Date::Calc qw(Add_Delta_YM Nth_Weekday_of_Month_Year);
use Date::Manip;
use IO::Uncompress::Gunzip qw{gunzip};

use RailDB::TrainTypes;
use RailDB::Trains;
use RailDB::Schedule;

use base qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw() ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	updateTrainsList
	updateTrainSchedule
);

our $VERSION = '0.01';

our %dayvals = (
	SUN => 64,
	MON => 32,
	TUE => 16,
	WED =>  8,
	THU =>  4,
	FRI =>  2,
	SAT =>  1,
);

our @classvals = qw(1A 2A 3A CC FC SL 2S);

our ($sundate, $sunmon);

my ($day, $mon, $year) = ( localtime )[3..5];
$year += 1900;
$mon += 1;
($year, $mon, $day) = Add_Delta_YM($year, $mon, 1, 0, 1);
($year, $sunmon, $sundate) = Nth_Weekday_of_Month_Year($year, $mon, 7, 1);

our $fareurl = 'http://www.indianrail.gov.in/fare_enq.html';
	


# Preloaded methods go here.

sub updateTrainsList {
	
#	RailDB::Trains->db_Main()->do("update zz_trains set active = 0");
	
	my $ua = LWP::UserAgent->new( (agent => 'MSIE 8 Beta Build 34651') );

	my @trtypes = RailDB::TrainTypes->search(active => 1);
	for my $trtype (@trtypes) {

		print 'Updating: ' . $trtype->name . "with" . $trtype->url . "\n";
		my $resp = $ua->get( $trtype->url );	
		next unless $resp->is_success;
		
		my $page = $resp->content;
		my $strm = HTML::TokeParser->new( \$page );

		croak 'No form on Page!' unless $strm->get_tag('form');

		while ( my $token = $strm->get_tag('th') ) {
			last if ($strm->get_trimmed_text eq 'Train Number'); 
		}
		$strm->get_tag('/tr');

		my (@arr, $idx, $currstr);
		while ( my $token = $strm->get_token ) {
			my $x = $token->[0];

			if ($x eq 'S') {
				my $tag = $token->[1];
				if ($tag eq 'tr') {
					@arr = ();
					$idx = 0;
				}
				elsif ($tag eq 'td') {
					$currstr = '';
				} 
			}
			elsif ($x eq 'E') {
				my $tag = $token->[1];
				if ($tag eq 'tr') {
					croak "Problem: $#arr Rows!" unless ($#arr == 5);
					_updatetrnrec(\@arr, $trtype->id);
				}
				elsif ($tag eq 'td') {
					$arr[$idx] = _trimclean($currstr);
					++$idx;
				}
				elsif ($tag eq 'table') {
					last;
				}
			}
			elsif ($x eq 'T') {
				$currstr .= $token->[1];
			}
		}
	}
}

sub _updatetrnrec {
	# Train Number, Train Name, Source Name, Departure Time, Destination Name, Arrival Time
	my ($dref, $type) = @_;
	
	if ( my $this = RailDB::Trains->retrieve($dref->[0]) ) {
		print 'Updating ' . $dref->[0] . "\n";

		$this->set(
			longname => $dref->[1],
			startname => $dref->[2],
			starttime => $dref->[3],
			endname => $dref->[4],
			endtime => $dref->[5],
			type => $type,
			recdupdton => UnixDate('now', '%d-%b-%Y %I:%M:%S %p'),
			active => 1,
			sessionid => 0,
		);
		$this->update();
		
	}
	else {
		print 'Creating ' . $dref->[0] . "\n";

		RailDB::Trains->insert({
			shortname => $dref->[0],
			longname => $dref->[1],
			startname => $dref->[2],
			starttime => $dref->[3],
			endname => $dref->[4],
			endtime => $dref->[5],
			type => $type,
			recdupdton => UnixDate('now', '%d-%b-%Y %I:%M:%S %p'),
			active => 1,
		});
	}

	return 1;
}

sub updateTrainSchedule {

#	RailDB::Trains->db_Main()->do("update zz_trains set schdupdton = null");
	
	my $page = WWW::Mechanize::GZip->new();
	$page->agent_alias('Windows IE 6');
	$page->stack_depth(3);

	my @trtypes = RailDB::TrainTypes->search(active => 1);
	for my $trtype (@trtypes){
		print 'URL ' . $trtype->url . ':';

		$page->get( $trtype->url );

		croak "Failed to get page: $trtype->{url}\n" 
			unless $page->success();
		croak "Cant Find Form on this page\n" 
			unless ( my $form = $page->form_name('trn_num') );
			
		my @radiovals = $form->find_input('lccp_trnname', 'radio')->possible_values;

		my $enc;
LOOP_TRN:
		for (@radiovals) {

			my $trnval = $_;
			$trnval =~ s/^\s+//;
			$trnval =~ s/\s+$//;
			
			# next if _skipthis($trnval);
			
			print "Now submitting $trnval: ";	

			$page->field(lccp_trnname => $_);
			my $resp = $page->submit_form(form_name => 'trn_num');

			if (! $resp->is_success) {
				print "Failure Submitting form 1: " . $resp->status_line . "\n";
				$page->back();
				next LOOP_TRN;
			}

#			$enc = $resp->header('Content-Encoding');
						
			if (my @nextform = $page->forms) {

				croak "Cannot find expected form" 
					unless (my $subform = $page->form_name('trn_path'));
				
				my @subradiovals = $subform->find_input('lccp_trn_no', 'radio')->possible_values;

				for my $inval (@subradiovals) {

					next unless ( _trimclean($inval) eq _trimclean($_) );

					$page->field(lccp_trn_no => $inval);
					my $subres = $page->submit_form(form_name => 'trn_path');

					if (! $subres->is_success) {
						print "Failure Submitting form 2: " . $subres->status_line . "\n";
						$page->back();
						$page->back();
						next LOOP_TRN;
					}
				
#					$enc = $subres->header('Content-Encoding');

					my $content = $subres->content;
					
#					if ($enc eq 'gzip') {
#						my $txt;
#						gunzip \$content => \$txt;
#						$content = $txt;	
#					}
					_process_sch_table(_trimclean($_), \$content);
					$page->back();
				}
			}
			else {
				my $content = $resp->content;
#				if ($enc eq 'gzip') {
#					my $txt;
#					gunzip \$content => \$txt;
#					$content = $txt;	
#				}
				_process_sch_table(_trimclean($_), \$content);
			}
			print "...Done!\n";
			$page->back();
		}
	}	
	return 1;	
}

sub _process_sch_table {
	my ($trnno, $cref) = @_;
	croak "Cant Parse Page" unless ( my $strm = HTML::TokeParser->new( $cref ) );
	# Find the Header Row with "Train Number" as the Contents
	while ( my $token = $strm->get_tag('th') ) {
		last if ($strm->get_trimmed_text eq 'Train No'); 
	}
	# Go to the beginning of the Runs-On data column
	$strm->get_tag('/tr');
	for (1..4) {
		$strm->get_tag('/td');
	}

	# Get each column from here and calculate runson;
	my $runson = 0;
	my ($currstr, $x);

LOOP_DOW:	
	while ( my $token = $strm->get_token ) {
		$x = $token->[0];
		if ($x eq 'S') {
			if ($token->[1] eq 'td') {
				$currstr = '';
			}
		}
		elsif ($x eq 'E') {
			if ($token->[1] eq 'td') {
				$currstr =~ s/^\s+//;
				$currstr =~ s/\s+$//;
				croak "Undefined Day of Week: $currstr" unless defined $dayvals{$currstr};
				$runson += $dayvals{$currstr};
			}
			elsif ($token->[1] eq 'tr') {
				last LOOP_DOW;
			}
		}
		elsif ($x eq 'T') {
			$currstr .= $token->[1];
		}
	}
	
	my $this = RailDB::Trains->retrieve($trnno);
	if (! $this) {
		print "Cant find Train $trnno in Train Table\n";
	}
	else {
		$this->set(runson => $runson);
		$this->update;
	}

	while ( my $token = $strm->get_tag('th') ) {
		last if ($strm->get_trimmed_text eq 'SNo'); 
	}
	# Go to the beginning of the Runs-On data column
	$strm->get_tag('/tr');
	
	# Now we are at the beginning of the schedule table.
	my (@arr, $idx, $slip);
LOOP_TRNSTOPS:
	while ( my $token = $strm->get_token ) {
		my $x = $token->[0];
		if ($x eq 'S') {
			if ($token->[1] eq 'tr') {
				@arr = ();
				$idx = 0;
			}
			elsif ($token->[1] eq 'td') {
				$currstr = '';
			} 
		}
		elsif ($x eq 'E') {
			if ($token->[1] eq 'tr') {
				if ($slip) {
					$slip = 0;
					print "Slipped!!!...";
					next LOOP_TRNSTOPS;
				}
				croak "Problem: $#arr Rows!" unless ($#arr == 8);
				_updateschrec($trnno, \@arr);
			}
			elsif ($token->[1] eq 'td') {
				$arr[$idx] = _trimclean($currstr);
				$slip = 1 if ($arr[$idx] eq 'Slip Route');
				++$idx;
			}
			elsif ($token->[1] eq 'table') {
				last LOOP_TRNSTOPS;
			}
		}
		elsif ($x eq 'T') {
			$currstr .= $token->[1];
		}
	}

	$this->set(schdupdton => UnixDate('now', '%d-%b-%Y %I:%M:%S %p'), sessionid => 2);
	$this->update();
	
	return 1;	
}

sub _skipthis {
	my $this = RailDB::Trains->retrieve(shift);
	return $this->schdupdton ? 0 : 1;
}

sub _updateschrec {
	# Serial Num, Stn Code, Stn Name, Route No, Arr, Dep, Distance, Day, Remark
	my ($trnno, $dref) = @_;
#	print join ':', @$dref;
#	print "\n" . $dref->[1] . "\n";	
	if ( my $trnstop = RailDB::Schedule->retrieve(shortname => $trnno, stopcode => $dref->[1]) ) {
#		print 'About to update: ' . $trnstop->shortname . ':' . $trnstop->stopcode . "\n";
		$trnstop->set(
			stopname => $dref->[2],
			arrival => $dref->[4],
			departure => $dref->[5],
			stopnum => $dref->[0],
			daynum => $dref->[7],
			remark => $dref->[8],
			routenum => $dref->[3],
			distance => $dref->[6],
		);
		$trnstop->update;
	}
	else {
		RailDB::Schedule->insert({
			shortname => $trnno,
			stopname => $dref->[2],
			stopcode => $dref->[1],
			arrival => $dref->[4],
			departure => $dref->[5],
			stopnum => $dref->[0],
			daynum => $dref->[7],
			remark => $dref->[8],
			routenum => $dref->[3],
			distance => $dref->[6],
		});
	}

	return 1;
}

#sub updateTrainFares {
#
#	$trnfares->execute;
#
#TRAINLOOP:
#	while ( my ($trnnum, $runson) = $trnfares->fetchrow_array ) {
#		$trnfromto->execute($trnnum, $trnnum);
#		my %cls = ();
#
#		while ( my ($from, $to, $dep, $day) = $trnfromto->fetchrow_array ) {
#
#		CLASSLOOP:
#			for my $class (@classvals) {
#
#				next CLASSLOOP if exists $cls{$class};
#				my @fares = _getfare_from_to(
#								trnnum => $trnnum, 
#								day => _gettraveldate($runson, $day), 
#								month => $sunmon, 
#								from => $from, 
#								to => $to, 
#								class=> $class
#							);
#
#				if ($fares[0] == 0) {
#					$cls{$class} = 1;
#				}
#				elsif ($fares[0] == -1) {
#					next TRAINLOOP;
#				}
#				elsif ($fares[0] == 1) {
#					shift @fares;
#					unshift @fares, ($trnnum, $from, $to, $class);
#					_insertdbfare(@fares);
#				}
#				
#			}
#		}
#	}
#	return 1;
#}
#
#sub _insertdbfare {
#	
#	my @fares = @_;
#	print join ':', @fares;
#	print "\n";
#	$trnfaresins->bind_param(1, $fares[1], {TYPE => DBI::SQL_VARCHAR});
#	$trnfaresins->bind_param(2, $fares[2], {TYPE => DBI::SQL_VARCHAR});
#	$trnfaresins->bind_param(3, $fares[3], {TYPE => DBI::SQL_VARCHAR});
#	$trnfaresins->bind_param(4, $fares[4], {TYPE => DBI::SQL_INTEGER});
#	$trnfaresins->bind_param(5, $fares[5], {TYPE => DBI::SQL_INTEGER});
#	$trnfaresins->bind_param(6, $fares[6], {TYPE => DBI::SQL_INTEGER});
#	$trnfaresins->bind_param(7, $fares[7], {TYPE => DBI::SQL_INTEGER});
#	$trnfaresins->bind_param(8, $fares[9], {TYPE => DBI::SQL_INTEGER});
#	$trnfaresins->bind_param(9, '0', 		   {TYPE => DBI::SQL_INTEGER});
#	$trnfaresins->bind_param(10, $fares[0],{TYPE => DBI::SQL_VARCHAR});
#	$trnfaresins->execute;
#	$dbh->commit;
#	return 1;
#}

sub _gettraveldate {
	my $runson = shift;
	my $day = shift;
	
	my $dayval = 64;
	my $date = $sundate;
	
	while (!($runson & $dayval))  {
		++$date;
		$dayval = $dayval >> 1;
	}
	return ($date + $day - 1)	
}

sub _trimclean {
	return '' unless my $str = shift;
	$str =~ s/\&nbsp\;//g;
	$str =~ s/^\s+//;
	$str =~ s/\s+$//;
	$str =~ s/\s+/ /g;
	return $str;
}

#my $pageame = WWW::Mechanize->new();
#$page->get($fareurl);
#$page->form_name('fare_enq');
#
#sub _getfare_from_to {
#
#	my %this = @_;
#			
#	$page->set_fields(	lccp_trnno 	  => $this{trnnum},
#						lccp_day 	  => $this{day},
#						lccp_month	  => $this{month},
#						lccp_srccode  => $this{from},
#						lccp_dstncode => $this{to},
#						lccp_classopt => $this{class},
#						lccp_enrtcode => 'NONE',
#						lccp_viacode  => 'NONE',
#						lccp_age	  => 30,
#						lccp_frclass1 => 'ZZ',
#						lccp_frclass2 => 'ZZ',
#						lccp_frclass3 => 'ZZ',
#						lccp_frclass4 => 'ZZ',
#						lccp_frclass5 => 'ZZ',
#						lccp_frclass6 => 'ZZ',
#						lccp_frclass7 => 'ZZ',
#						lccp_disp_avl_flg => 1,
#						lccp_conc 	  => 'ZZZZZZ',
#					);
#	my $resp = $page->click_button(value => 'Get It');
#
#	if (! $resp->is_success ) {
#		carp('Died: ' . $resp->status_line . "\n"); 
#		return ();
#	}
#	
#	my $content = $resp->content;
#	$page->back;	
#	return (_processfareresp(\$content));	
#}
#
#sub _processfareresp {
#	my $cref = shift;
#	croak "Cant Parse Page" unless ( my $strm = HTML::TokeParser->new( $cref ) );
#	
#	return (-1, "Cancelled") unless $strm->get_tag("/h1");
#	$strm->get_tag("/script");
#	
#	my $tkn;
#	while ($tkn = $strm->get_token) {
#		last if ($tkn->[0] eq 'S');
#	}
#	
#	my @fares = ();
#	if ($tkn->[1] eq 'form') {
#		$strm->get_tag('/table');
#		$strm->get_tag('/table');
#		$strm->get_tag('/table');
#		$strm->get_tag('/tr');
#
#		# Now at begining of the first row
#		push @fares, 1;
#		$strm->get_tag('td');
#		push @fares, $strm->get_trimmed_text("/td");	
#		$strm->get_tag('td');
#		push @fares, $strm->get_trimmed_text("/td");	
#		$strm->get_tag('td');
#		push @fares, $strm->get_trimmed_text("/td");	
#		$strm->get_tag('td');
#		push @fares, $strm->get_trimmed_text("/td");	
#		$strm->get_tag('td');
#		push @fares, $strm->get_trimmed_text("/td");
#		
#		$strm->get_tag('table');
#		$strm->get_tag('td');
#		push @fares, $strm->get_trimmed_text("/td");
#
#	}
#	elsif ($tkn->[1] eq 'h2') {
#		push @fares, 0;
#		push @fares, $strm->get_trimmed_text('/h2');
#	}
#	else {
#		push @fares, -1;
#	}
#	
#	return @fares;
#}


1;

