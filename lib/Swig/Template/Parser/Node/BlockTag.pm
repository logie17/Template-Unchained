package Swig::Template::Parser::Node::BlockTag;
use Moose;

has name => ( is => 'ro', required => 1);
has statement => ( is => 'ro', 'required' => 1 );

has runtime_blocks => (is => 'rw', isa => 'ArrayRef');

sub eval {
  my ($self, $context) = @_;
  #Return the block if super block exists
  return $self->else_statement if $self->else_statement;
}

no Moose; 1;
