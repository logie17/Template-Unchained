package Swig::Template::Runtime;
use Moose;

has context => ( is => 'ro', required => 1, default => sub { Swig::Template::RunTime::Context->new } );

no Moose; 1;
