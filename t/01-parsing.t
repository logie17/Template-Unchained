#! /usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 2;

use_ok('Swig::Template');

my $snippet;
$snippet = '
    {% if a %} 
        <div> 2 </div>
      {% if b %} 
          <div> 2 </div>
      {% end if %}
      {% if c %} 
          <div> 2 </div>
      {% end if %}
    {% end if %}
    {% if d %} 
        <div> 2 </div>
    {% end if %}
';

$snippet =~ s/\n//g;
$snippet =~ s/\s\s+//g;
my $swig = Swig::Template->new(html => $snippet, data => {});

my $html = $swig->render;
my $tree = $swig->tree;

is_deeply $tree, bless( { 'nodes' => [ bless( { 'statement' => [ bless( { 'content' => '<div> 2 </div>' }, 'Swig::Template::Parser::Node::AnythingElse' ), bless( { 'statement' => [ bless( { 'content' => '<div> 2 </div>' }, 'Swig::Template::Parser::Node::AnythingElse' ) ], 'else_statement' => undef, 'condition' => ' b ' }, 'Swig::Template::Parser::Node::IfTag' ), bless( { 'statement' => [ bless( { 'content' => '<div> 2 </div>' }, 'Swig::Template::Parser::Node::AnythingElse' ) ], 'else_statement' => undef, 'condition' => ' c ' }, 'Swig::Template::Parser::Node::IfTag' ) ], 'else_statement' => undef, 'condition' => ' a ' }, 'Swig::Template::Parser::Node::IfTag' ), bless( { 'statement' => [ bless( { 'content' => '<div> 2 </div>' }, 'Swig::Template::Parser::Node::AnythingElse' ) ], 'else_statement' => undef, 'condition' => ' d ' }, 'Swig::Template::Parser::Node::IfTag' ) ] }, 'Swig::Template::Parser::Node::Document' );

done_testing;
