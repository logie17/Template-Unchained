package Swig::Template::Parser::Node::AnythingElse;
use Moose;

has content => ( is => 'ro', required => 1);

sub eval { return $_[0]->content }

no Moose; 1;

