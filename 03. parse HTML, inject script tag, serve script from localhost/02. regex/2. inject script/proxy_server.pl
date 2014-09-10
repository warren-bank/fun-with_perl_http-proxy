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
			my $scripts	= '<script type="text/javascript" src="http://localhost:81/custom.js"></script>';

			$html		=~ s![\r\n]+! !gm;
			$html		=~ s!<script.*?</script>!!ig;
			$html		=~ s!(<head[^>]*>)!${1}${scripts}!i;

			$$dataref	= $html;
		}
	),
	mime => 'text/html', scheme => 'http', host => 'localhost:81', path => '/test.html'
);

$proxy->start;
