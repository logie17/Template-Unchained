package Swig::Template::Parser::Grammar;
use Pegex::Base;
extends 'Pegex::Grammar';

use constant file => 'lib/swig-template-pgx/swig-template.pgx';

sub make_tree {
  {
    '+grammar' => 'swig',
    '+toprule' => 'document',
    '+version' => '0.0.1',
    'anything_else' => {
      '.rgx' => qr/\G([^\{]+)/
    },
    'document' => {
      '+min' => 0,
      '.ref' => 'top_level_block'
    },
    'for_tag' => {
      '.all' => [
        {
          '.rgx' => qr/\G\s*\{%\s*for\s*(\w+)\s*in\s*(.+)\s*\s*%\}\s*/
        },
        {
          '.ref' => 'statement'
        },
        {
          '.rgx' => qr/\G\s*\{%\s*end\s*for\s*%\}\s*/
        }
      ]
    },
    'if_tag' => {
      '.any' => [
        {
          '.all' => [
            {
              '.rgx' => qr/\G\s*\{%\s*if([^\{%]+)\s*%\}\s*/
            },
            {
              '.ref' => 'statement'
            },
            {
              '.rgx' => qr/\G\s*\{%\s*end\s*if\s*%\}\s*/
            }
          ]
        },
        {
          '.all' => [
            {
              '.rgx' => qr/\G\s*\{%\s*if([^\{%]+)\s*%\}\s*/
            },
            {
              '.ref' => 'statement'
            },
            {
              '.rgx' => qr/\G\s*\{%\s*else\s*%\}\s*/
            },
            {
              '.ref' => 'statement'
            },
            {
              '.rgx' => qr/\G\s*\{%\s*end\s*if\s*%\}\s*/
            }
          ]
        }
      ]
    },
    'statement' => {
      '+min' => 0,
      '.ref' => 'top_level_block'
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
