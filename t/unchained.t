#! /usr/bin/env perl

use strict;
use warnings;
use Test::More;

use_ok('Swig::Template');

my ($html, $swig, $rhtml);

$html=' <html> 
  {% if foo %} 
    <div>bar</div>
  {% end if %}
</html>';

$swig = Swig::Template->new(html => $html, data => { foo => 1 })->render;
$rhtml = $swig->html;

$rhtml =~ s/[\n\s]+//g;

is $rhtml, '<html><div>bar</div></html>';

$html='
  <html>
  {% for x in foo %}
    <div>foo - {% x %}</div>
  {% end for %}
';

$swig = Swig::Template->new(html => $html, data => { foo => [qw(1 2 3)] })->render;
$rhtml = $swig->html;
$rhtml =~ s/[\n\s]+//g;

is $rhtml, '<html><div>foo-1</div><div>foo-2</div><div>foo-3</div>';

done_testing;
