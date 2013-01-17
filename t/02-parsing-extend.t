#! /usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 2;

use_ok('Swig::Template');

my $snippet = '
{% extends "foo.html" %}
{{ foo.bar }}
<html>
    <body>
    </body>
</html>';

my $swig = Swig::Template->new(html => $snippet, data => {});

my $html = $swig->render;
my $tree = $swig->tree;
use Data::Dumper;
warn Dumper($tree);
is_deeply $tree, [
          [
            {'file_name' => 'foo.html'}
          ],
          'foo.bar ',
          '<html>
    <body>
    </body>
</html>'];
