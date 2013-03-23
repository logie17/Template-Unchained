#! /usr/bin/env perl

use strict;
use warnings;
use Test::More;

use_ok('Template::Unchained');

my $snippet = '
{% extends "t/data/extend01.html" %}
{{ foo.bar }}
{% block neato %}
<html>
    <body>
    </body>
</html>';

my $unchained = Template::Unchained->new(html => $snippet, data => {});

my $html = $unchained->render;
my $tree = $unchained->tree;
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
