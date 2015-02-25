#!/usr/bin/perl -w
#
# temporalia_solrify.pl
#
# This script converts the original temporalia documents
# to the one that can be indexed by Solr.
# It assumes that all input files have been uncompressed.
# It will save a new file in the same folder as original.
#
#  INPUT: xxxxxxxxxxx.xml
# OUTPUT: xxxxxxxxxxx_solr.xml
#
# NO WARRANTY WHATSOEVER. USE WITH YOUR OWN RISK.
#
# Hideo Joho <hideo at slis dot tsukuba dot ac dot jp>
#
sub usage {
	die <<"End";

  Usage: $0 file [...]

End
}

use strict;
use warnings;

if(!@ARGV || $ARGV[0] =~ /^-+h/) {
	usage();
}

while(my $infile = shift @ARGV) {
	my $outfile = $infile;
	$outfile =~ s/\.xml/_solr\.xml/;

	open(IN, $infile) || die "Cannot open $infile: $!";
	open(OUT, ">$outfile") || die "Cannot open $outfile: $!";
	print STDERR "$infile > $outfile\n";
# Tell Solr to add these docs
	print OUT "<add>\n";
# Initialise variables
	my %data = ();
# (Near) Line-by-line processing
	while(<IN>) {
# Decoding some characters
		s/\&/\&amp\;/g;
# doc ids
		if(/^<doc id=([^>]+)>/) {
			$data{'id'} = $1;
			next;
		}
# meta info tags
		if(/<tag name=\"([^\"]+)\">([^<]+)</) {
			$data{$1} = $2;
# date needs to be reformatted for solr
			if($1 eq 'date') {
				$data{$1} .= "T00:00:00Z";
			}
			next;
		}
# dump all you've got so far
		if(/^<\/doc>/) {
			print OUT "<doc>\n";
			for my $key (reverse sort keys %data) {
				print OUT "\t<field name=\"$key\">$data{$key}<\/field>\n";
			}
			print OUT "<\/doc>\n";
			%data = ();
		}
# strip out all the other tags
		s/<[^>]*>//g;
		s/\]\]>//g;
		$data{'content'} .= $_;
	}
	print OUT "</add>\n";
	close(IN) || die "Cannot close $infile: $!";
	close(OUT) || die "Cannot close $outfile: $!";
}
