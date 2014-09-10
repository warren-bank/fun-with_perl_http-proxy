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

# iteration counter
my $counter = 1;

# remove all pre-existing scripts, inject arbitrary custom script into <head>
my @filter = (
	response => HTTP::Proxy::BodyFilter::simple->new(
		sub {
			my ( $self, $dataref, $message, $protocol, $buffer ) = @_;

			if (
				($single_pass) && (defined $buffer)
			){return;}

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

if ($single_pass){
	# http://perldoc.perl.org/perldata.html#List-value-constructors
	@filter = (response => HTTP::Proxy::BodyFilter::complete->new, @filter);
}

$proxy->push_filter(@filter);
$proxy->start;
