#!/usr/bin/perl -l

use strict;
use Image::ExifTool qw(:Public);
use Date::Parse;

my $root = "/Users/ajg/P";

my %dests = ();

while ( my $file = <> ) {
	chomp( $file );

	my $info = ImageInfo($file);
#	DUMP($file, sort keys %$info);

#	for my $key ( sort grep { /Date/ } keys %$info ) {
#		print $file, " ", $key, " ", $info->{$key}, "\n";
#	}

	my $date = $info->{CreateDate};
	$date = $info->{DateTimeOriginal} unless $date;
	$date = $info->{FileModifyDate} unless $date;
	my ($ss,$mm,$hh,$day,$month,$year,$zone) = strptime($date);

	my $dest = undef; 
	if ( defined $year ) {
		if ( defined $month ) {
			$dest = sprintf("%s/%04d/%02d", $root, 1900+$year, $month );
		}
		else {
			$dest = sprintf("%s/%04d/other", $root, 1900+$year );
		}
	}
	else { 
		$dest = sprintf("%s/other", $root);
	}

	#$file =~ s/\(/\\(/g;
	#$file =~ s/\)/\\)/g;
	$file =~ s/'/'"'"'/g;
	printf( "mv '%s' '%s'\n", $file, $dest );

	$dests{$dest} += 1;
}

for my $dest ( sort keys %dests ) {
	printf( "mkdir -p '%s'\n", $dest );
}

sub DUMP {
	use Data::Dumper;
	print Dumper(@_);
}

# END
