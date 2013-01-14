#! /usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 2;

use_ok('Swig::Template');

my $snippet = '
<html>
    <body>
    {% if a %} <div> 2 </div> {% end if %}
    {% for x in foo %}
        {% if a %} <div> 2 </div> {% end if %}
    {% end for %}
    </body>
</html>';

my $swig = Swig::Template->new(html => $snippet, data => {});

my $html = $swig->render;
my $tree = $swig->tree;
is_deeply $html, [
'
<html>
    <body>
    ',
          [
            ' a ',
            [
              '<div> 2 </div> '
            ]
          ],
          [
            [
              'x ',
              'foo '
            ],
            [
              [
                ' a ',
                [
                  '<div> 2 </div> '
                ]
              ]
            ]
          ],
          '</body>
</html>'
];

