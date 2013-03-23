#! /usr/bin/env perl

use strict;
use warnings;
use Test::Most;

use_ok('Template::Unchained::Runtime::Object');
use_ok('Template::Unchained::Runtime::Class');

my $object = Template::Unchained::Runtime::Object->new(class => Template::Unchained::Runtime::Class->new );
dies_ok { $object->call('foo') };

done_testing;
