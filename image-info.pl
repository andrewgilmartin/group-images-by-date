#!/usr/bin/perl -l

use strict;
use Image::ExifTool qw(:Public);
use Date::Parse;
for my $file ( @ARGV ) {
	chomp( $file );

	my $info = ImageInfo($file);
	for my $key ( sort keys %$info ) {
		my $value = $info->{$key};
		print "$file $key $info->{$key}";
	}
}

# END
