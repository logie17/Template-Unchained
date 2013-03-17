package Swig::Template::Parser::Node::CallNode;
use Moose;

has receiver => ( is => 'rw');
has method => ( is => 'rw');
has arguments => ( is => 'rw');

sub eval {
  my ($self, $context) = @_;
  if ( !$self->receiver && $context->locals->{$self->method} ) {
      return $context->locals->{$self->method};
  }
  return;
}

no Moose; 1;
