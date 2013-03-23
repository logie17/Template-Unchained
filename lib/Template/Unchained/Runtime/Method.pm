# This is a block, the naming may change in the future
package Template::Unchained::Runtime::Method;
use Template::Unchained::Runtime::Context;
use Moose;

has params => ( is => 'rw', isa => 'ArrayRef' );
has body => ( is => 'rw' );

sub call {
  my ($self, $receiver, @args) = @_;
   
  my $context = Template::Unchained::Runtime::Context->new(receiver => $receiver);

  # Shift off the passed in arguments for lexical context
  for my $param ( @{$self->params} ) {
    $context->local($param, shift @args);
  }

  # Eval the block of code
  $self->body->eval($context);
}

no Moose; 1;
