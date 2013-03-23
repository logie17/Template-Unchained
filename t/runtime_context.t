#! /usr/bin/env perl

use strict;
use warnings;
use Test::Most;

use_ok('Template::Unchained::Runtime::Context');

my $context = Template::Unchained::Runtime::Context->new;

is $context->locals->{'lower'}->('ABC'), 'abc';
is $context->locals->{'length'}->('ABC'), 3;
is $context->locals->{'length'}->([qw(A B C)]), 3;

done_testing;
