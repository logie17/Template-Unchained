package Swig::Template::Parser::Data;
use Pegex::Base;
extends 'Pegex::Tree';
use Carp qw(croak);
use lexicals;
use File::Slurp qw(read_file);
use Swig::Template::Parser;

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
    
# Todo: implement inheritance    
#sub got_block_name { }
#sub got_block { }
#sub got_block_content { }

