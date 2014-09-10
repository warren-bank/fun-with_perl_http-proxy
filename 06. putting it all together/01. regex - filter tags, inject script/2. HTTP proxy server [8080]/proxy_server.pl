#!/usr/bin/perl -w

my $single_pass = 1;

use HTTP::Proxy qw( :log );
use HTTP::Proxy::BodyFilter::simple;
use strict;

if ($single_pass){
	# http://search.cpan.org/~book/HTTP-Proxy-0.301/lib/HTTP/Proxy/BodyFilter/complete.pm
	use HTTP::Proxy::BodyFilter::complete;
}

# a very simple proxy
my $proxy = HTTP::Proxy->new( @ARGV );

# remove all blacklisted html tags, inject arbitrary custom script into <head>
my @filter = (
	response => HTTP::Proxy::BodyFilter::simple->new(
		sub {
			my ( $self, $dataref, $message, $protocol, $buffer ) = @_;

			if (
				($single_pass) && (defined $buffer)
			){return;}

			my $html	= $$dataref;
			my $tags	= 'script|iframe|object|embed';
			my $scripts	= join('', (
				'<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>',
				'<script type="text/javascript" src="http://localhost:81/custom.js"></script>'
			));

			# strip carriage returns
			$html		=~ s![\r\n]+! !gm;

			# filter all tags in the blacklist
			$html		=~ s!<(?:${tags})[^>]*/>!!ig;
			$html		=~ s!<(${tags}).*?</\1>!!ig;

			# inject custom scripts
			$html		=~ s!(<head[^>]*>)!${1}${scripts}!i;

			# cleanup
			$html		=~ s!>\s+<!><!g;
			$html		=~ s!^\s+!!;
			$html		=~ s!\s+$!!;

			$$dataref	= $html;
		}
	),
	mime => 'text/html', scheme => 'http'
);

if ($single_pass){
	# http://perldoc.perl.org/perldata.html#List-value-constructors
	@filter = (response => HTTP::Proxy::BodyFilter::complete->new, @filter);
}

$proxy->push_filter(@filter);
$proxy->start;
