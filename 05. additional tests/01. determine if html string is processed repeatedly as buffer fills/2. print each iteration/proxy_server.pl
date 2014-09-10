#!/usr/bin/perl -w

use HTTP::Proxy qw( :log );
use HTTP::Proxy::BodyFilter::simple;
use strict;

# a very simple proxy
my $proxy = HTTP::Proxy->new( @ARGV );

# iteration counter
my $counter = 1;

# remove all pre-existing scripts, inject arbitrary custom script into <head>
$proxy->push_filter(
	response => HTTP::Proxy::BodyFilter::simple->new(
		sub {
			my $dataref	= $_[1];
			my $html	= $$dataref;

			# strip carriage returns
			$html		=~ s![\r\n]+! !gm;

			# replace static tokens with dynamic tokens, to identify which iteration is responsible for the data update
			$html		=~ s!0!${counter}!g; $counter++;

			$html		= '-------------------------------------------------' . "\n" . $html . "\n";

			$$dataref	= $html;
		}
	),
	mime => 'text/html', scheme => 'http', host => 'localhost:81', path => '/test.html'
);

$proxy->start;
