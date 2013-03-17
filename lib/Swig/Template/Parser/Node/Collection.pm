package Swig::Template::Parser::Node::Collection;
use Moose;

has nodes => ( is => 'rw', isa => 'ArrayRef' );

sub eval {
  my ($self, $context) = @_;
  my $result;
  for ( @{$self->nodes } ){
    $result .= $_->eval($context);
  }
  return $result;
}

no Moose; 1;
