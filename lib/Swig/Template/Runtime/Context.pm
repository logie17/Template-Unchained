package Swig::Template::Runtime::Context;
use Moose;

has receiver => ( is => 'rw' );
has locals => ( is => 'rw', traits => [qw( Hash )], isa => 'HashRef', handles => { local => 'accessor' }, default => sub { {}  } );

sub BUILD {
  my $self = shift;
  $self->local('lower', sub { lc(shift) });
  $self->local('length', sub { 
    my $item = shift;
    ref $item eq 'ARRAY' ? scalar @$item : length $item;
  });
}

no Moose; 1;
