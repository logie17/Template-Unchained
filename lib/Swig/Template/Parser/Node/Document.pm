package Swig::Template::Parser::Node::Document;
use Moose;

has nodes => ( is => 'rw', isa => 'ArrayRef' );

no Moose; 1;
