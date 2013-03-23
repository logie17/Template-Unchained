#! /usr/bin/env perl

use strict;
use warnings;
use Test::Most;

use_ok('Template::Unchained::Runtime::Method');
use_ok('Template::Unchained::Runtime::Object');
use_ok('Template::Unchained::Runtime::Class');

my $object = Template::Unchained::Runtime::Object->new(class => Template::Unchained::Runtime::Class->new );
my $method = Template::Unchained::Runtime::Method->new(params => [ qw(foo bar) ], body => body->new);

$method->call($object, 1, 2); 

# Sort of silly mocking
{
  package body;
  use Test::Most;
  use Hash::MoreUtils qw(slice);
  sub new { bless {} }
  sub eval { 
    my ($self, $context) = @_;
    is_deeply({slice($context->{locals},qw(bar foo))}, { bar => 2, foo => 1 });
  }
}


done_testing;
