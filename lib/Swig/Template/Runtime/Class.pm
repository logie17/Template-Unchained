package Template::Unchained::Runtime::Class;
use Moose;
use Template::Unchained::Runtime::Object;

has runtime_blocks => ( is => 'rw', isa => 'HashRef' );
has runtime_methods => ( is => 'rw', traits => [qw( Hash )], isa => 'HashRef', handles => { runtime_method => 'accessor' } );
has runtime_superclass => ( is => 'rw', isa => 'Template::Unchained::Runtime::Class' );

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
  return Template::Unchained::Runtime::Object->new( class => $self );
}
  
no Moose; 1;
