package Template::Unchained::Runtime::Context;
use Moose;

has receiver => ( is => 'rw' );
has locals => ( is => 'rw', traits => [qw( Hash )], isa => 'HashRef', handles => { local => 'accessor' }, default => sub {{ }} );
has classes => ( is => 'rw', traits => [qw(Hash)], isa => 'HashRef', handles => { class => 'accessor'}, default => sub {{ }});
has current_class => (is => 'rw');
has current_self => (is => 'rw');

sub BUILD {
  my $self = shift;
  $self->local('lower', sub { lc(shift) });
  $self->local('length', sub { 
    my $item = shift;
    ref $item eq 'ARRAY' ? scalar @$item : length $item;
  });
}

no Moose; 1;
