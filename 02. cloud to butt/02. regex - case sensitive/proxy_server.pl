#!/usr/bin/perl -w

use HTTP::Proxy qw( :log );
use HTTP::Proxy::BodyFilter::simple;
use strict;

# a very simple proxy
my $proxy = HTTP::Proxy->new( @ARGV );

# the "cloud to butt" filter
$proxy->push_filter(
	response => HTTP::Proxy::BodyFilter::simple->new(
		sub {
			my $dataref	= $_[1];
			my $html	= $$dataref;

			$html		=~ s!THE CLOUD!MY BUTT!g;
			$html		=~ s!The Cloud!My Butt!g;
			$html		=~ s!The cloud!My butt!g;
			$html		=~ s!the cloud!my butt!gi;

			$$dataref	= $html;
		}
	)
);

$proxy->start;
