package Swig::Template::Parser::Data;
use Pegex::Base;
extends 'Pegex::Tree';
use lexicals;

sub extends_file { 
    my ( $file_name ) = shift; 
    lexicals; 
}

sub got_extends_file { 
    my ($self, $node) = @_;
    use Data::Dumper;
    warn Dumper($node);
    extends_file($node);
}

