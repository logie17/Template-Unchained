package Swig::Template::Parser::Node::IfTag;
use Moose;

has condition => ( is => 'ro', required => 1);
has statement => ( is => 'ro', 'required' => 1 );
has else_statement => ( is => 'ro' );

sub eval {
  my ($self, $context) = @_;
  my $return_val;
  if ( eval { $self->condition->eval($context) } ) {
    return $self->statement->eval($context);
  }
  return $self->else_statement if $self->else_statement;
}

no Moose; 1;
