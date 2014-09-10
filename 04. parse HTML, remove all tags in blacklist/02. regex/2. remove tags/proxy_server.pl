#!/usr/bin/perl -w

use HTTP::Proxy qw( :log );
use HTTP::Proxy::BodyFilter::simple;
use strict;

# a very simple proxy
my $proxy = HTTP::Proxy->new( @ARGV );

# remove all pre-existing scripts, inject arbitrary custom script into <head>
$proxy->push_filter(
	response => HTTP::Proxy::BodyFilter::simple->new(
		sub {
			my $dataref	= $_[1];
			my $html	= $$dataref;
			my $tags	= 'script|iframe|object|embed';

			# strip carriage returns
			$html		=~ s![\r\n]+! !gm;

			# filter all tags in the blacklist
			$html		=~ s!<(?:${tags})[^>]*/>!!ig;
			$html		=~ s!<(${tags}).*?</\1>!!ig;

			# cleanup
			$html		=~ s!>\s+<!><!g;
			$html		=~ s!^\s+!!;
			$html		=~ s!\s+$!!;

			$$dataref	= $html;
		}
	),
	mime => 'text/html', scheme => 'http', host => 'localhost:81', path => '/test.html'
);

$proxy->start;
