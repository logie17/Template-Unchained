package Template::Unchained::Parser::Data;
use Pegex::Base;

extends 'Pegex::Tree';
use Template::Unchained::Parser;
use Template::Unchained::Parser::Node::AnythingElse;
use Template::Unchained::Parser::Node::BlockTag;
use Template::Unchained::Parser::Node::Collection;
use Template::Unchained::Parser::Node::ForTag;
use Template::Unchained::Parser::Node::IfTag;
use Template::Unchained::Parser::Node::ExtendTag;
use Template::Unchained::Parser::Node::CallNode;

sub got_identifier { 
  Template::Unchained::Parser::Node::CallNode->new( receiver => undef, method => $_[1], arguments => [] );
};

sub got_variable {
  my $variable = $_[1][0];
  if ( my $filter = $_[1][1] ) {
    $variable = Template::Unchained::Parser::Node::CallNode->new( receiver => undef, method => $filter, arguments => [$variable] );
  }
  return Template::Unchained::Parser::Node::Collection->new( nodes => [$variable] );
}

sub got_anything_else { 
  Template::Unchained::Parser::Node::AnythingElse->new( content => $_[1] ); 
}

sub got_block_tag { 
  my $body = Template::Unchained::Parser::Node::Collection->new(nodes => $_[1][1]);
  Template::Unchained::Parser::Node::BlockTag->new(name => $_[1][0], body => $body); 
}

sub got_document {
  Template::Unchained::Parser::Node::Collection->new(nodes => $_[1]); 
}

sub got_extends_tag {
  Template::Unchained::Parser::Node::Collection->new(nodes => $_[1]);
}

sub got_extends_file { 
  Template::Unchained::Parser::Node::ExtendTag->new(filename => $_[1]) 
}

sub got_if_tag { 
  my $statement = Template::Unchained::Parser::Node::Collection->new(nodes => $_[1]->[1]);
  my $else_statement = defined $_[1]->[2] ? Template::Unchained::Parser::Node::Collection->new(nodes => $_[1]->[2]) : undef;
  Template::Unchained::Parser::Node::IfTag->new(condition => $_[1]->[0], statement => $statement, else_statement => $else_statement );
}

sub got_for_tag { 
  my $statement = Template::Unchained::Parser::Node::Collection->new( nodes => $_[1]->[2]);
  Template::Unchained::Parser::Node::ForTag->new( variable => $_[1]->[0], list => $_[1]->[1], statement => $statement );
}

