#! /usr/bin/env perl

use strict;
use warnings;
use Test::More;

use_ok('Swig::Template');

my $html;

$html=' <html> {% if foo %} <div>bar</div>    {% end if %} </html>';

my $swig = Swig::Template->new(html => $html, data => { foo => 1 })->render;

is $swig->html, ' <html> <div>bar</div>    </html>';

done_testing;
