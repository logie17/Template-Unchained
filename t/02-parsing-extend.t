#! /usr/bin/env perl

use strict;
use warnings;
use Test::More;

use_ok('Swig::Template');

my $snippet = '
{% extends "t/data/extend01.html" %}
{{ foo.bar }}
{% block neato %}
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
            {
              'raw_content' => 'testing 
  {% block foo %}
',
              'file_name' => 't/data/extend01.html',
              'parsed_content' => [
                                    'testing 
  ',
                                    [
                                      'foo ',
                                      []
                                    ]
                                  ]
            }
          ],
          'foo.bar ',
          [
            'neato ',
            [
              '<html>
    <body>
    </body>
</html>'
            ]
          ]
];

done_testing;
