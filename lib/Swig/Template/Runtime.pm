package Template::Unchained::Runtime;
use Moose;

has context => ( is => 'ro', required => 1, default => sub { Template::Unchained::RunTime::Context->new } );

no Moose; 1;
