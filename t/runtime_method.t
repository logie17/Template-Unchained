#! /usr/bin/env perl

use strict;
use warnings;
use Test::Most;

use_ok('Swig::Template::Runtime::Method');
use_ok('Swig::Template::Runtime::Object');
use_ok('Swig::Template::Runtime::Class');

my $object = Swig::Template::Runtime::Object->new(class => Swig::Template::Runtime::Class->new );
my $method = Swig::Template::Runtime::Method->new(params => [ qw(foo bar) ], body => body->new);

$method->call($object, 1, 2); 

# Sort of silly mocking
{
  package body;
  use Test::Most;
  sub new { bless {}, $_[0] }
  sub eval { 
    my ($self, $context) = @_;
    is_deeply $context->{locals}, { bar => 2, foo => 1 };
  }
}


done_testing;
