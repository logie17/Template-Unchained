package Swig::Template::Parser::Node::ForTag;
use Moose;

has variable => ( is => 'ro', required => 1);
has list => ( is => 'ro', 'required' => 1 );
has statement => ( is => 'ro' );

sub eval {
  my ($self, $context) = @_;
  # Need to implment
}

no Moose; 1;
