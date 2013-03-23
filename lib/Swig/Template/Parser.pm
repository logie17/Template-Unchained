use 5.010;

use Pegex 0.21 ();

package Template::Unchained::Parser;
use Pegex::Base;
extends 'Pegex::Module';

require Template::Unchained::Parser::Grammar;
require Template::Unchained::Parser::Data;

has grammar_class => 'Template::Unchained::Parser::Grammar';
has receiver_class => 'Template::Unchained::Parser::Data';

1;
