#! /usr/bin/env perl

use strict;
use warnings;
use Test::More;

use_ok('Template::Unchained');
my ($html, $unchained, $rhtml);

$html=' <html> 
  {% if foo %} 
    <div>bar</div>
  {% end if %}
</html>';

$unchained = Template::Unchained->new(html => $html, data => { foo => 1 })->render;
$rhtml = $unchained->html;

$rhtml =~ s/[\n\s]+//g;

is $rhtml, '<html><div>bar</div></html>';

$html='
  <html>
  {% for x in foo %}
    <div>foo - {{ x }}</div>
  {% end for %}
';

$unchained = Template::Unchained->new(html => $html, data => { foo => [qw(1 2 3)] })->render;
$rhtml = $unchained->html;
$rhtml =~ s/[\n\s]+//g;

is $rhtml, '<html><div>foo-1</div><div>foo-2</div><div>foo-3</div>';

$html='
  <html>
    <div>{{ x | length}}</div>
';

$unchained = Template::Unchained->new(html => $html, data => { x => [qw(1 2 3)] })->render;
$rhtml = $unchained->html;
$rhtml =~ s/[\n\s]+//g;

is $rhtml, '<html><div>3</div>';

$html = '{% extends "t/data/parent1.html" %}';

$unchained = Template::Unchained->new(html => $html, data => {})->render;
$rhtml = $unchained->html;
$rhtml =~ s/[\n\s]+//g;

is $rhtml, '<html><title>ParentTitle</title><body>foobar</body></html>';

$html = '{% extends "t/data/parent1.html" %}{% block title %}Child Title{% end block %}';

$unchained = Template::Unchained->new(html => $html, data => {})->render;
$rhtml = $unchained->html;
$rhtml =~ s/[\n\s]+//g;

is $rhtml, '<html><title>ParentTitle</title><body>foobar</body></html>';

done_testing;
