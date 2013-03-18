package Swig::Template::Parser::Node::ForTag;
use Moose;

has variable => ( is => 'ro', required => 1);
has list => ( is => 'ro', 'required' => 1 );
has statement => ( is => 'ro' );

sub eval {
  my ($self, $context) = @_;

  my $return_val;
  for my $var ( @{ $self->list->eval($context) } ) {
    $context->local($self->variable->method, $var);
    $return_val .= $self->statement->eval($context);
  }
  return $return_val; 
}

no Moose; 1;
