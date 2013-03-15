package Swig::Template::Runtime::Class;
use Moose;
use Swig::Template::Runtime::Object;

has runtime_blocks => ( is => 'rw', isa => 'HashRef' );
has runtime_superclass => ( is => 'rw', isa => 'Swig::Template::Runtime::Class' );

sub lookup {
  my ($self, $block_name) = @_;

  my $block = $self->runtime_blocks->{$block_name};   
  unless ( $block ) {
    if ( $self->runtime_superclass) {
      return $self->runtime_superclass->lookup($block_name);
    }
  }
  return $block;
}

# Sort of like a constructor?
sub new_object {
  my $self = shift;  
  return Swig::Template::Runtime::Object->new( class => $self );
}
  
no Moose; 1;
