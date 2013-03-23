package Template::Unchained::Runtime::Object;
use Moose;

has class => ( is => 'rw', isa => 'Template::Unchained::Runtime::Class', required => 1 );

sub call {
  my ($self, $method, @args) = @_;
  return $self->class->lookup($method)->call($self, @args);
}

no Moose; 1;
