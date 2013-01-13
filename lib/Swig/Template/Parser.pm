use 5.010;

use Pegex 0.21 ();
use boolean 0.28 ();

package Swig::Template::Parser;
use Pegex::Base;
extends 'Pegex::Module';

require Swig::Template::Grammar;
require Swig::Template::Data;

our $VERSION = '0.01';

has grammar_class => 'Swig::Template::Parser::Grammar';
has receiver_class => 'Swig::Template::Parser::Data';

1;

=head1 SYNOPSIS

    my $parsed_goodness = Swig::Template->parse($json);

=head1 DESCRIPTION

Swig::Template::Parser
