#! /usr/bin/env perl

use strict;
use warnings;
use Test::More;

use_ok('Template::Unchained::Runtime::Class');

my $class;
$class = Template::Unchained::Runtime::Class->new(runtime_blocks => { foo => 'block of code' });
is $class->lookup('foo'), 'block of code';

my $superclass = Template::Unchained::Runtime::Class->new(runtime_blocks => { bar => 'block of super class code'});
is $superclass->lookup('bar'), 'block of super class code';
is $class->lookup('bar'), undef;
$class->runtime_superclass($superclass);
is $class->lookup('bar'), 'block of super class code';

isa_ok $class->new_object, 'Template::Unchained::Runtime::Object';

$class->runtime_method('foo', 'runtime method block');
is $class->runtime_methods->{'foo'}, 'runtime method block';


done_testing;
