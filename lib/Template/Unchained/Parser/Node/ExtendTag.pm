package Template::Unchained::Parser::Node::ExtendTag;

use Template::Unchained::Runtime::Class;
use Moose;
use File::Slurp qw(read_file);
use Carp qw(croak);

has filename => ( is => 'ro', 'required' => 1, isa => 'Str' );
has body => ( is => 'ro', builder => '_build_body', lazy => 1 );
has class_name => ( is => 'ro', required => 1, default => sub { 'base' });
has super_name => ( is => 'rw' );

sub _build_body {
  my $self = shift;
  return $self->parse_file($self->filename);
}

sub eval {
  my ($self, $context) = @_;

  my $class = $context->classes->{$self->class_name};

  unless ( $class ) {
    $class = Template::Unchained::Runtime::Class->new;
    $context->class($self->class_name, $class);
  } 
  
  my $class_context = Template::Unchained::Runtime::Context->new(current_self => $class, current_class => $class);
  return $self->body->eval($class_context);
}

sub parse_file { 
  my ( $self, $file_name ) = @_;
  if ( -e $file_name ) {
    my $raw_content = read_file($file_name);
    my ($abs_file_name) = $file_name =~ m/([^\/]+$)/g;
    $self->super_name($abs_file_name);
    return Template::Unchained::Parser->parse($raw_content);
  }
  croak "We found [$file_name] but can't find it";
}


no Moose; 1;
