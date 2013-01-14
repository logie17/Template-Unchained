use 5.010;

use Pegex 0.21 ();

package Swig::Template::Parser;
use Pegex::Base;
extends 'Pegex::Module';

require Swig::Template::Parser::Grammar;
require Swig::Template::Parser::Data;

has grammar_class => 'Swig::Template::Parser::Grammar';
has receiver_class => 'Swig::Template::Parser::Data';

1;
