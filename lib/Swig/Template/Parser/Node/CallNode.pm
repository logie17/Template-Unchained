package Swig::Template::Parser::Node::CallNode;
use Moose;

has receiver => ( is => 'rw');
has method => ( is => 'rw');
has arguments => ( is => 'rw', default => sub { [] });

sub eval {
  my ($self, $context) = @_;
  my $has_arguments = scalar @{$self->arguments} ? 1 : 0;
  if ( !$self->receiver && $context->locals->{$self->method} && !$has_arguments ) {
    return $context->locals->{$self->method};
  } elsif ( $self->arguments && $context->locals->{$self->method} ) {
    my @args = map { $_->eval($context) } @{$self->arguments};
    my $method = $context->locals->{$self->method};
    return &{$context->locals->{$self->method}}(@args);
  }
  return;
}

no Moose; 1;
