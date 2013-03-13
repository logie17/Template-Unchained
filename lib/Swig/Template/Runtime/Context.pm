package Swig::Template::Runtime::Context;
use Moose;

has locals => ( is => 'rw', isa => 'HashRef' );

no Moose; 1;
