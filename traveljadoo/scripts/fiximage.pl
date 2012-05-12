#! /usr/bin/perl

use strict;
use warnings;

use File::Copy;
use Image::Magick;

my $imgdirname = '/home/tpcom/mod_127';
opendir my $imgdir, $imgdirname or die "Cannot open $imgdirname: $!";

my @imgfiles = grep {/\.jpg$/} readdir($imgdir);

foreach (@imgfiles) {
	my $f = lc($_);
	$f =~ s/\s+/\_/g;
	$f =~ s/\_0/\_/g;
	my $filename = $imgdirname . '/' . $_;
	my $targetfilename = $imgdirname . '/fixed/' . $f;
	
	my $size = compress_image($filename, 61440, $targetfilename, 1, 2, , 1);
	print "$_ reduced to $size\n";
}

exit;

sub compress_image
{
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
