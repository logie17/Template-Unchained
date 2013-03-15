package Swig::Template::Runtime::Object;
use Moose;

has class => ( is => 'rw', isa => 'Swig::Template::Runtime::Class', required => 1 );

sub call {
  my ($self, $method, @args) = @_;
  return $self->class->lookup($method)->call($self, @args);
}

no Moose; 1;
