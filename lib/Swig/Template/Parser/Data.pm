package Swig::Template::Parser::Data;
use Pegex::Base;

extends 'Pegex::Tree';
use Swig::Template::Parser;
use Swig::Template::Parser::Node::AnythingElse;
use Swig::Template::Parser::Node::BlockTag;
use Swig::Template::Parser::Node::Collection;
use Swig::Template::Parser::Node::ForTag;
use Swig::Template::Parser::Node::IfTag;
use Swig::Template::Parser::Node::ExtendTag;
use Swig::Template::Parser::Node::CallNode;

sub got_identifier { 
  Swig::Template::Parser::Node::CallNode->new( receiver => undef, method => $_[1], arguments => [] );
};

sub got_anything_else { 
  Swig::Template::Parser::Node::AnythingElse->new( content => $_[1] ); 
}

sub got_block_tag { 
  Swig::Template::Parser::Node::BlockTag->new(name => $_[1]->[0], body => $_[1]->[1]); 
}

sub got_document {
  Swig::Template::Parser::Node::Collection->new(nodes => $_[1]); 
}

sub got_extends_file { 
  Swig::Template::Parser::Node::ExtendTag->new(filename => $_[1]) 
}

sub got_if_tag { 
  my $statement = Swig::Template::Parser::Node::Collection->new(nodes => $_[1]->[1]);
  my $else_statement = defined $_[1]->[2] ? Swig::Template::Parser::Node::Collection->new(nodes => $_[1]->[2]) : undef;
  Swig::Template::Parser::Node::IfTag->new(condition => $_[1]->[0], statement => $statement, else_statement => $else_statement );
}

sub got_for_tag { 
  my $statement = defined $_[1]->[2]  ? Swig::Template::Parser::Node::Collection->new(nodes => $_[1]->[2]) : undef;
  Swig::Template::Parser::Node::ForTag->new(variable => $_[1]->[0], list => $_[1]->[1], statement => $statement );
}

