package Template::Unchained::Parser::Grammar;
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
    'block_tag' => {
      '.all' => [
        {
          '.rgx' => qr/\G\s*\{%\s*block\s*(.+)\s*\s*%\}\s*/
        },
        {
          '+min' => 0,
          '.ref' => 'expressions'
        }
      ]
    },
    'document' => {
      '+min' => 0,
      '.ref' => 'expressions'
    },
    'expression' => {
      '.any' => [
        {
          '.ref' => 'for_tag'
        },
        {
          '.ref' => 'if_tag'
        },
        {
          '.ref' => 'extends_tag'
        },
        {
          '.ref' => 'variable'
        },
        {
          '.ref' => 'block_tag'
        },
        {
          '.ref' => 'operator'
        }
      ]
    },
    'expressions' => {
      '.any' => [
        {
          '.ref' => 'anything_else'
        },
        {
          '.ref' => 'expression'
        }
      ]
    },
    'extends_file' => {
      '.rgx' => qr/\G\s*([^\"]+)\s*/
    },
    'extends_tag' => {
      '.all' => [
        {
          '.rgx' => qr/\G\s*\{%\s*extends\s*"/
        },
        {
          '.ref' => 'extends_file'
        },
        {
          '.rgx' => qr/\G"\s*%\}\s*/
        }
      ]
    },
    'for_tag' => {
      '.all' => [
        {
          '.rgx' => qr/\G\s*\{%\s*for/
        },
        {
          '.ref' => 'expression'
        },
        {
          '.rgx' => qr/\Gin/
        },
        {
          '.ref' => 'expression'
        },
        {
          '.rgx' => qr/\G\s*%\}\s*/
        },
        {
          '+min' => 0,
          '.ref' => 'expressions'
        },
        {
          '.rgx' => qr/\G\s*\{%\s*end\s*for\s*%\}\s*/
        }
      ]
    },
    'identifier' => {
      '.rgx' => qr/\G\s*(\w+)\s*/
    },
    'if_tag' => {
      '.any' => [
        {
          '.all' => [
            {
              '.rgx' => qr/\G\s*\{%\s*if/
            },
            {
              '.ref' => 'expression'
            },
            {
              '.rgx' => qr/\G\s*%\}\s*/
            },
            {
              '+min' => 0,
              '.ref' => 'expressions'
            },
            {
              '.rgx' => qr/\G\s*\{%\s*end\s*if\s*%\}\s*/
            }
          ]
        },
        {
          '.all' => [
            {
              '.rgx' => qr/\G\s*\{%\s*if/
            },
            {
              '.ref' => 'expression'
            },
            {
              '.rgx' => qr/\G\s*%\}\s*/
            },
            {
              '+min' => 0,
              '.ref' => 'expressions'
            },
            {
              '.rgx' => qr/\G\s*\{%\s*else\s*%\}\s*/
            },
            {
              '+min' => 0,
              '.ref' => 'expressions'
            },
            {
              '.rgx' => qr/\G\s*\{%\s*end\s*if\s*%\}\s*/
            }
          ]
        }
      ]
    },
    'operator' => {
      '.ref' => 'identifier'
    },
    'variable' => {
      '.all' => [
        {
          '.rgx' => qr/\G\s*\{\{\s*/
        },
        {
          '.ref' => 'expression'
        },
        {
          '.ref' => 'variable_filter'
        },
        {
          '.rgx' => qr/\G\s*\}\}\s*/
        }
      ]
    },
    'variable_filter' => {
      '.rgx' => qr/\G\s*(?:\|\s*(length))?\s*/
    }
  }
}

1;
