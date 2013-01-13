package Swig::Template::Grammar;
use Pegex::Base;
extends 'Pegex::Grammar';

use constant file => 'lib/swig-template-pgx/swig-template.pgx';

sub make_tree {
  {
    '+grammar' => 'swig',
    '+toprule' => 'document',
    '+version' => '0.0.1',
    'anything_else' => {
      '.rgx' => qr/\G((?:(?!\{%[^%\}]+%\})[\s\S])+)/
    },
    'document' => {
      '+min' => 0,
      '.ref' => 'top_level_block'
    },
    'for_tag' => {
      '.rgx' => qr/\G\s*\{%\s*for\s*(.+)\s*in\s*(.+)\s*\s*%\}\s*([\s\S]+)\s*\{%\s*end\s*for\s*%\}\s*/
    },
    'if_tag' => {
      '.rgx' => qr/\G\s*\{%\s*if(.+)\s*%\}\s*([\s\S]+)\s*\{%\s*end\s*if\s*%\}\s*/
    },
    'swig' => {
      '.any' => [
        {
          '.ref' => 'for_tag'
        },
        {
          '.ref' => 'if_tag'
        }
      ]
    },
    'top_level_block' => {
      '.any' => [
        {
          '.ref' => 'swig'
        },
        {
          '.ref' => 'anything_else'
        }
      ]
    }
  }
}

1;
