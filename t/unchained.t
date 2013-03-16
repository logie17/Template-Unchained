#! /usr/bin/env perl

use strict;
use warnings;
use Test::More;

use_ok('Swig::Template');

my $html;

$html=<<EOF;
<html>
  {% if foo %}
    <div>bar</div>    
  {% end if %}
</html>
EOF

my $swig = Swig::Template->new(html => $html, data => { foo => 1 })->render;

is $swig->html,<<EOF;
<html>
  <div>bar</div>
</html>
EOF

done_testing;
