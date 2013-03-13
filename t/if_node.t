#! /usr/bin/env perl

use strict;
use warnings;
use Test::More;

use_ok('Swig::Template::Parser::Node::IfTag');

my $object;
$object = Swig::Template::Parser::Node::IfTag->new(condition => 1, statement => 'foo'); 
is $object->eval, 'foo';

$object = Swig::Template::Parser::Node::IfTag->new(condition => 0, statement => 'foo'); 
is $object->eval, undef;

$object = Swig::Template::Parser::Node::IfTag->new(condition => 0, statement => 'foo', else_statement => 'bar'); 
is $object->eval, 'bar';

$object = Swig::Template::Parser::Node::IfTag->new(condition => 1, statement => 'foo', else_statement => 'bar'); 
is $object->eval, 'foo';

done_testing;
