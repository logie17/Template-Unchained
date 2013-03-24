package Template::Unchained::Parser::Node::BlockTag;
use Moose;
use Template::Unchained::Runtime::Method;

has name => ( is => 'ro', required => 1);
has params => ( is => 'ro', default => sub {[]});
has body => ( is => 'ro', 'required' => 1);

sub eval {
  my ($self, $context) = @_;
  my $method = Template::Unchained::Runtime::Method->new(params => $self->params, body => $self->body);
  $context->current_class->runtime_method($self->name, $method);
  return $method->call($context->current_self, $self->params);
}

no Moose; 1;
