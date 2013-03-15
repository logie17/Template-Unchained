package Swig::Template::Parser::Node::BlockTag;
use Moose;

has name => ( is => 'ro', required => 1);
has params => ( is => 'ro');
has body => ( is => 'ro', 'required' => 1);

sub eval {
  my ($self, $context) = @_;
  my $method = Swig::Template::Runtime::Method->new(params => $self->params, body => $self->body);
  $context->current_class->runtime_method($self->name, $method);
}

no Moose; 1;
