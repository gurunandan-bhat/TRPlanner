package Odyssey::Images;

use strict;
use warnings;

use lib qw{../};

use base qw(Odyssey);

use OdysseyDB::Image;
use OdysseyDB::ImageProperties;
use OdysseyDB::ImageCategories;
use OdysseyDB::ImageTypes;
use OdysseyDB::City;
use OdysseyDB::State;
use OdysseyDB::Hotel;
use OdysseyDB::Itineraries;

use HTTP::BrowserDetect;
use Image::Magick;
use Net::FTP;
use Image::Size;

use File::Basename qw(fileparse fileparse_set_fstype);
use File::Copy;

use Data::Dumper;


our $VERSION = '0.01';

# Preloaded methods go here.

sub setup {
	my $app = shift;
	
	$app->mode_param('mode');

	$app->run_modes(
		main =>	'main',
		fiximage => 'fiximage',
	);

	$app->start_mode('main');
	$app->error_mode('errhndlr');

} 

sub main {
	
	my $app = shift;
	
	my @imgcats = map {{
		IMGCATID => $_->imagecategories_id,
		IMGCATNAME => $_->imagecategory,
	}} OdysseyDB::ImageCategories->retrieve_all;
	
	my @imgtypes = map {{
		IMGTYPEID => $_->imagetypes_id,
		IMGTYPENAME => $_->imagetype,
	}} OdysseyDB::ImageTypes->retrieve_all;
	
	my $tpl = $app->load_tmpl('imgupload_form.tpl', die_on_byad_params => 0);
	$tpl->param(
		IMGCATEGORIES => \@imgcats,
		IMGTYPES => \@imgtypes,
	);
	
	return $tpl->output;	
}

sub fiximage {
	
	my $app = shift;
	my $q = $app->query;

	my $imgcat = $q->param('imgcat');
	my $imgtype = $q->param('imgtype');
	my $imgname = $q->param('imgfile');
	
	my @imgprops = OdysseyDB::ImageProperties->search(
		imagecategories_id => $imgcat,
		imagetypes_id => $imgtype,
	);
	
	die({type => 'error', msg => 'You must select an Image Category'})
		unless $imgcat;
		
	die({type => 'error', msg => 'You must select an Image Type'})
		unless $imgtype;
		
	die({type => 'error', msg => 'You must select a File to Upload'})
		unless $imgname;

	die({type => 'error', msg => 'There are no Images in this Category of this Type'})
		unless @imgprops;

	
	my $browser = HTTP::BrowserDetect->new();
	my $osstr = $browser->windows ? 'MSWin32' : (
		$browser->unix ? 'Unix' : (
			$browser->mac ? 'MacOS' : 'Unknown'
		)
	);
	fileparse_set_fstype($osstr);

	my $imgdir = '/home/admin/Odyssey/webroot/images';
	my ($ofname, $odirname, $osufx) = fileparse($imgname, qr/\.[^.]*/);
	my $leafname = lc($ofname . $osufx);

	my $imgpattern = $imgprops[0]->imagepattern;
	(my $prnpattern = $imgpattern) =~ s/\\//g;
	$prnpattern =~ s/\+//g;
	
	die({type => 'error', msg => "The File Name must match the pattern $prnpattern"})
		unless $leafname =~ /$imgpattern/;

	my $objid = $1;
	die({type => 'error', msg => 'Numbers cannot begin with a 0'})
		if $objid =~ /^0/;

	my $srno = $2;
	die({type => 'error', msg => 'Numbers cannot begin with a 0'})
		if $srno =~ /^0/;
	$srno = $srno | 0;
	my $imgfname = qq{$imgdir/$leafname}; 
	my $imgfh = $q->upload('imgfile');
	$imgfh = $imgfh->handle;

	my ($width, $height) = imgsize($imgfh);

	die({type => 'error', msg => 'Incorrect Width and Height. Dimensions must be' . $imgprops[0]->imagewidth . 'x' . $imgprops[0]->imageheight})
		unless (($imgprops[0]->imagewidth == $width) && ($imgprops[0]->imageheight == $height));
	
	File::Copy::copy($imgfh, $imgfname) or
		die({type => 'error', msg => "Error Copying File $imgname to $imgfname: " . $!});

	my $bkupimgfname = qq{$imgdir/fixed/$leafname};

	if ((lc($osufx) eq '.gif') or (lc($osufx) eq '.png')) {
	    File::Copy::copy($imgfname, $bkupimgfname) or
		die({type => 'error', msg => "Error Copying File $imgname to $imgfname: " . $!});
	}
	else {
	    my $size = compress_image($imgfname, 51200, $bkupimgfname, 1, 2, 0);
	}

	my $filesize = -s $bkupimgfname;
	
	my $conn = Net::FTP->new('www.travellers-palm.com')
		or die({type => 'error', msg => "Cannot connect to remote server: $@"});
		
	$conn->login('tpcom', 'goaf1984')
		or die({type => 'error', msg => 'Cannot login to remote server: ' . $conn->message});

	$conn->cwd('public_html/images/' . $imgprops[0]->imagefolder . '/')
		or die({type => 'error', msg => 'Cannot Change to Images Directory: ' . $conn->message});

	$conn->binary();

	my $remotefname = $conn->put($bkupimgfname);
	die({type => 'error', msg => 'Error Copying File  to Remote Server'}) 
		unless $remotefname;
	
	my $alttag = _get_metadata($imgcat, $objid);
	
	my @images = OdysseyDB::Image->search(imagename => $leafname);
	my $dbh = OdysseyDB::Image->db_Main();
	$dbh->{odbc_ignore_named_placeholders} = 1;
	if (@images) {

		foreach (@images) {
			my $recid = $_->images_id;
			my $altalttag = 'Title ' + $alttag;
			my $sth = $dbh->prepare("update images set
					imagename = " . $dbh->quote($leafname) .
					", imagecategories_id = $imgcat,
					imagetypes_id = $imgtype,
					imageobjectid = $objid,
					filesize = $filesize,
					alttag = " . $dbh->quote($alttag) .
					", title = " . $dbh->quote($altalttag) .
					", srno = $srno
				where 
					images_id = $recid
			");
			$sth->execute;
		}
	}
	else {
	    my $altalttag = 'Title ' + $alttag;
		my $sth = $dbh->prepare("insert into images (
				imagename,
				imagecategories_id,
				imagetypes_id,
				imageobjectid,
				filesize,
				alttag,
				title,
				srno
			)
			values (
				" . $dbh->quote($leafname) . ",
				$imgcat,
				$imgtype,
				$objid,
				$filesize, " .
				$dbh->quote($alttag) . ",
				" . $dbh->quote($altalttag) . ",
				$srno
			)");
		$sth->execute;
	}
	$app->redirect('images.cgi');
}

sub compress_image {
	my $image_file = shift;
	my $desired_size = shift;
	my $target_file = shift;
	my $min_quality = shift;
	my $step = shift;
	my $verbose_level = shift;
	my $image;
	my $status;
	my $size;
	my $quality;
	my $last_quality;

	local *IMAGE;
	my $blob;

	die __PACKAGE__ . " compress_image() required image file name missing.\n"
	  if (!defined($image_file));

	die __PACKAGE__ . " compress_image() required image file size missing.\n"
	  if (!defined($desired_size));

	$target_file = $image_file if (!defined($target_file));
	$min_quality = 1 if (!defined($min_quality));

	if (!defined($step)) {
		$step = 5;
	}
	elsif ($step < 0) {
		$step = -$step;
	}

	die "Can't compress $image_file: No such file or directory.\n"
	  if (! -e $image_file);

	if ($verbose_level > 0) {
		print "Compressing $image_file.\n";
		print "Resulting image will be in $target_file.\n";
	}

	$image = Image::Magick->new();
	$status = $image->Read($image_file);
	warn "$status" if "$status";

	$size = $image->Get('filesize');
	$last_quality = $quality = $image->Get('quality');

	if ($verbose_level > 1)	{
		print "Initial image size:	$size\n";
		print "Initial image quality: $quality\n";
	}

	while ( ($size > $desired_size) && ($size > 0) && (($quality -= $step) >= $min_quality) ) {
		$blob = $image->ImageToBlob(quality => $quality);
		$size = length($blob);
		$last_quality = $quality;

		if ($verbose_level > 1)	{
			print "Current image size:	$size\n";
			print "Current image quality: $quality\n";

		}
	}

	$size = $image->Get('filesize');

	if ($verbose_level > 1)	{
		print "Final image size:	  $size\n";
		print "Final image quality:   $last_quality\n";
	}

	undef $image;

	if (defined($blob))	{
		open(IMAGE, ">$target_file") or die
		  "Can't open $target_file for writing: $!\n";
		print IMAGE $blob;
		close(IMAGE) or die "Failed to close $target_file: $!\n";
	}
	elsif ($image_file ne $target_file)	{
		copy($image_file, $target_file) or
		  die "Failed to copy $image_file to $target_file: $!\n";
	}

	return ( ($size > 0) && ($size <= $desired_size) ) ? 1 : 0;
}


sub _get_metadata {
	
	my $tblid = shift;
	my $objid = shift;
	
	if ($tblid == 1) {
		
		my $city = OdysseyDB::City->retrieve(cities_id => $objid);
		my $state = $city->states_id->state;
		
		return $city->city . ", $state, India";
	}
	elsif ($tblid == 2) {

		my $hotel = OdysseyDB::Hotel->retrieve(addressbook_id => $objid);
		my $city = $hotel->cities_id;
		my $state = $city->states_id->state;

		return $hotel->organisation . ', ' . $city->city . ", $state, India";		
	}
	elsif (($tblid == 3) or ($tblid == 4))  {
		
		my $itin = OdysseyDB::Itineraries->retrieve(fixeditin_id => $objid);
		return "Custom Tour: " . $itin->title;
	}
	elsif ($tblid == 5) {
		
		my $state = OdysseyDB::State->retrieve(states_id => $objid);
		return $state->state . ", India";
	}
	else {
		return;
	}
} 

1;
