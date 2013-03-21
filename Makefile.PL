use inc::Module::Install;

name     'Swig-Template';
all_from 'lib/Swig/Template.pm';
author   q{Logan Bell <loganbell@gmail.com>};
license  'perl';

build_requires 'Test::More';
requires 'Files::Slurp';
requires 'Pegex';
requires 'Moose';
requires 'Hash::MoreUtils';

test_requires 'Test::More';

auto_install;

WriteAll;

