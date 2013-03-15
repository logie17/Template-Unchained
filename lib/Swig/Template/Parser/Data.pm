package Swig::Template::Parser::Data;
use Pegex::Base;
extends 'Pegex::Tree';
use Carp qw(croak);
use lexicals;
use File::Slurp qw(read_file);
use Swig::Template::Parser;
use Swig::Template::Parser::Node::IfTag;

sub parse_file { 
    my ( $file_name ) = shift; 
    if ( -e $file_name ) {
        my $raw_content = read_file($file_name);
        my $parsed_content = Swig::Template::Parser->parse($raw_content);
        return lexicals;
    }
    croak "We found [$file_name] but can't find it";
}

sub got_extends_file { 
    my ($self, $node) = @_;
    parse_file($node);
}


sub got_if_tag { Swig::Template::Parser::Node::IfTag->new(condition => $_[1]->[0], statement => $_[1]->[1], else_statement => $_[1]->[2]) }
sub got_block_tag { Swig::Template::Parser::Node::BlockTag->new(name => $_[1]->[0], statement => $_[1]->[1] }

