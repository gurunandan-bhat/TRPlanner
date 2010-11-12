package Rail::Miner;

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
use RailDB::Cities;
use RailDB::Fares;

use DBI;

use Data::Dumper;

use base qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw() ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	updateTrainsList
	updateTrainSchedule
	updateTrainFares
);

our $VERSION = '0.01';

our %dayvals = (
	SUN => 1,
	MON => 2,
	TUE => 4,
	WED => 8,
	THU => 16,
	FRI => 32,
	SAT => 64,
);

our @classvals = qw(2A 3A CC);

our ($sundate, $sunmon);

my ($day, $mon, $year) = ( localtime )[3..5];
$year += 1900;
$mon += 1;
($year, $mon, $day) = Add_Delta_YM($year, $mon, 1, 0, 1);
($year, $sunmon, $sundate) = Nth_Weekday_of_Month_Year($year, $mon, 7, 1);

my $page = WWW::Mechanize->new();
$page->get('http://www.indianrail.gov.in/fare_enq.html');

$page->form_name('fare_enq');

# Preloaded methods go here.

sub updateTrainsList {
	
#	RailDB::Trains->db_Main()->do("update zz_trains set active = 0");
	
	my $ua = LWP::UserAgent->new( (agent => 'MSIE 8 Beta Build 34651') );

	my @trtypes = RailDB::TrainTypes->search(active => 1);

TRNTYPE:
	for my $trtype (@trtypes) {

		print 'Updating: ' . $trtype->name . " from " . $trtype->url . "\n";
		my $resp = $ua->get( $trtype->url );	

		next TRNTYPE unless $resp->is_success;

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

		my @othertrns = qw{
			2001A     
			2002A     
			2019      
			2020      
			2101      
			2102      
			2123      
			2124      
			2308      
			2308A     
			2467      
			2468      
			2497      
			2498      
			2617      
			2644      
			2803      
			2903      
			2904      
			2956      
			2979      
			4096      
			4203      
			4204      
			4308      
			4555      
			5014A     
			5605      
			5606      
			6325      
			6326      
			6527      
			6589      
			8235      
			8236      
			9024      
			9109      
			9110      
			9304      
		};

		@radiovals = (@othertrns, @radiovals);
		
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
				
					my $content = $subres->content;
					
					_process_sch_table(_trimclean($_), \$content);
					$page->back();
				}
			}
			else {
				my $content = $resp->content;
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

	my @info;
	for (1..4) {
		$strm->get_tag('td');
		push @info, $strm->get_trimmed_text('/td');
	}
	$strm->get_tag('/td');

	my $shortname = $info[0];
	my $longname = $info [1];
	my $startname = $info[3];
	
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
	
	my $this = RailDB::Trains->retrieve(shortname => $trnno) ||
		RailDB::Trains->insert({
			shortname => $shortname,
			longname => $longname,
			startname => $startname,
		}
	);

	$this->set(runson => $runson);
	$this->update;

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

	$this->set(schdupdton => UnixDate('now', '%d-%b-%Y %I:%M:%S %p'), sessionid => 1);
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

	my $city = RailDB::Cities->retrieve(railwaycode => $dref->[1]);
	my $trnstn = $city ? $city->cities_id : 0;

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
			used => $trnstn,
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
			used => $trnstn,
		});
	}

	return 1;
}

sub updateTrainFares {

	my $fareqry = qq{
		select
			s1.shortname trnnum,
			s1.stopcode src,
			s2.stopcode destn,
			t.runson runson,
			s1.daynum daynum
		from
			zz_schedule s1,
			zz_schedule s2,
			zz_trains t
		where
			s1.used > 0 and
			s2.used > 0 and
			t.runson is not null and
			s1.shortname = s2.shortname and
			s2.shortname = t.shortname and
			s1.stopnum < s2.stopnum and
			s2.distance - s1.distance > 25 and
			s1.remark is null and
			s2.remark is null
		order by 
			1
	};

	my $dbh = RailDB::Schedule->db_Main();

	my $sth = $dbh->prepare($fareqry);
	$sth->execute;

	my %cls;
	my $prevtrn;
	TRAINLOOP:
	while ( my $trip = $sth->fetchrow_hashref("NAME_lc") ) {

		my $trnnum = $trip->{trnnum};
		my $src = $trip->{src};
		my $destn = $trip->{destn};
		my $runson = $trip->{runson};
		my $daynum = $trip->{daynum};
		my $traveldate = _gettraveldate($runson, $daynum);

		%cls = () if ($trnnum ne $prevtrn);

		print "$trnnum\t$src\t$destn\t$runson\t$daynum\n";

		CLASSLOOP:
		for my $class (@classvals) {

			next CLASSLOOP if $cls{$class};
			
			my @fares = _getfare_from_to(
				trnnum => $trnnum, 
				day => $traveldate, 
				month => $sunmon, 
				from => $src, 
				to => $destn, 
				class=> $class,
			);

			if ($fares[0] == 1) {

				shift @fares;
				unshift @fares, ($trnnum, $src, $destn, $class);
				
				_insertdbfare(@fares);
			}
			else {
				$cls{$class} = 1;
			}
		}
		$prevtrn = $trnnum;
	}
	return 1;
}

sub _insertdbfare {
	
	my @fares = @_;
	
	my $trip = RailDB::Fares->retrieve(
		trnnum => $fares[0],
		source => $fares[1],
		destn => $fares[2],
		class => $fares[3],
	);
	
	if ($trip) {
		$trip->set(
			basefare => $fares[4],
			resfare => $fares[5],
			sfstfare => $fares[6],
			othrfare => $fares[7],
			ttklfare => $fares[8],
			addlrfare => $fares[9],
		);
		$trip->update;
	}
	else {
		$trip = RailDB::Fares->insert({
			trnnum => $fares[0],
			source => $fares[1],
			destn => $fares[2],
			class => $fares[3],
			basefare => $fares[4],
			resfare => $fares[5],
			sfstfare => $fares[6],
			othrfare => $fares[7],
			ttklfare => $fares[8],
			addlrfare => $fares[9],
		});
	}
	
	return $trip->id;
}

sub _getfare_from_to {

	my %this = @_;
	
	$page->set_fields(
		lccp_trnno 	  => $this{trnnum},
		lccp_day 	  => $this{day},
		lccp_month	  => $this{month},
		lccp_srccode  => $this{from},
		lccp_dstncode => $this{to},
		lccp_classopt => $this{class},
		lccp_enrtcode => 'NONE',
		lccp_viacode  => 'NONE',
		lccp_age	  => 30,
		lccp_frclass1 => 'ZZ',
		lccp_frclass2 => 'ZZ',
		lccp_frclass3 => 'ZZ',
		lccp_frclass4 => 'ZZ',
		lccp_frclass5 => 'ZZ',
		lccp_frclass6 => 'ZZ',
		lccp_frclass7 => 'ZZ',
		lccp_disp_avl_flg => 1,
		lccp_conc 	  => 'ZZZZZZ',
	);

	my $resp = $page->click_button(value => 'Get It');

	if (! $resp->is_success ) {
		carp('Died: ' . $resp->status_line . "\n"); 
		return ();
	}
	
	my $content = $resp->content;
	$page->back;	
	return (_processfareresp(\$content));	
}

sub _processfareresp {
	my $cref = shift;
	croak "Cant Parse Page" unless ( my $strm = HTML::TokeParser->new( $cref ) );
	
	return (-1, "Cancelled") unless $strm->get_tag("/h1");
	$strm->get_tag("/script");
	
	my $tkn;
	while ($tkn = $strm->get_token) {
		last if ($tkn->[0] eq 'S');
	}
	
	my @fares = ();
	if ($tkn->[1] eq 'form') {
		$strm->get_tag('/table');
		$strm->get_tag('/table');
		$strm->get_tag('/table');
		$strm->get_tag('/tr');

		# Now at begining of the first row
		push @fares, 1;
		$strm->get_tag('td');
		push @fares, $strm->get_trimmed_text("/td");	
		$strm->get_tag('td');
		push @fares, $strm->get_trimmed_text("/td");	
		$strm->get_tag('td');
		push @fares, $strm->get_trimmed_text("/td");	
		$strm->get_tag('td');
		push @fares, $strm->get_trimmed_text("/td");	
		$strm->get_tag('td');
		push @fares, $strm->get_trimmed_text("/td");
		
		$strm->get_tag('table');
		$strm->get_tag('td');
		push @fares, $strm->get_trimmed_text("/td");

	}
	elsif ($tkn->[1] eq 'h2') {
		push @fares, 0;
		push @fares, $strm->get_trimmed_text('/h2');
	}
	else {
		push @fares, -1;
	}
	
	return @fares;
}

sub _gettraveldate {
	my $runson = shift;
	my $daynum = shift;
	
	my $dayval = 0b0001;
	my $date = $sundate;
	
	while (!($runson & $dayval))  {
		++$date;
		$dayval = $dayval << 1;
		die "Cant find match for Runs On! Dying!!" if $dayval > 64;
	}

	my $retval = $date + $daynum - 1;
	return $retval;	
}

sub _trimclean {
	return '' unless my $str = shift;
	$str =~ s/\&nbsp\;//g;
	$str =~ s/^\s+//;
	$str =~ s/\s+$//;
	$str =~ s/\s+/ /g;
	return $str;
}




1;

