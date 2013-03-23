#! /usr/bin/env perl

use strict;
use warnings;
use Test::More;

use_ok('Template::Unchained::Parser::Node::IfTag');

my $object;
$object = Template::Unchained::Parser::Node::IfTag->new(condition => 1, statement => 'foo'); 
is $object->eval, 'foo';

$object = Template::Unchained::Parser::Node::IfTag->new(condition => 0, statement => 'foo'); 
is $object->eval, undef;

$object = Template::Unchained::Parser::Node::IfTag->new(condition => 0, statement => 'foo', else_statement => 'bar'); 
is $object->eval, 'bar';

$object = Template::Unchained::Parser::Node::IfTag->new(condition => 1, statement => 'foo', else_statement => 'bar'); 
is $object->eval, 'foo';

done_testing;
