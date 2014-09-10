#!/usr/bin/perl -w

use HTTP::Proxy qw( :log );
use HTTP::Proxy::BodyFilter::simple;
use strict;

# a very simple proxy
my $proxy = HTTP::Proxy->new( @ARGV );

# the "cloud to butt" filter
$proxy->push_filter(
	response => HTTP::Proxy::BodyFilter::simple->new(
		sub { ${ $_[1] } =~ s!the cloud!my butt!ig }
	)
);

$proxy->start;
