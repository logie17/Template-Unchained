package Swig::Template::Runtime::Context;
use Moose;

has receiver => ( is => 'rw' );
has locals => ( is => 'rw', traits => [qw( Hash )], isa => 'HashRef', handles => { local => 'accessor' }, default => sub { {}  } );

no Moose; 1;
