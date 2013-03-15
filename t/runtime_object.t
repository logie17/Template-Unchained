#! /usr/bin/env perl

use strict;
use warnings;
use Test::Most;

use_ok('Swig::Template::Runtime::Object');
use_ok('Swig::Template::Runtime::Class');

my $object = Swig::Template::Runtime::Object->new(class => Swig::Template::Runtime::Class->new );
dies_ok { $object->call('foo') };

done_testing;
