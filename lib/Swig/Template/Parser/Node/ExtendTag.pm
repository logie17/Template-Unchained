package Swig::Template::Parser::Node::ExtendTag;

use Moose;
use File::Slurp qw(read_file);
use Carp qw(croak);

has filename => ( is => 'ro', 'required' => 1, isa => 'Str' );
has body => ( is => 'ro', builder => '_build_body', lazy => 1 );
has class_name => ( is => 'ro', required => 1, default => sub { 'base' });
has super_name => ( is => 'ro' );

sub _build_body {
  my $self = shift;
  return $self->parse_file($self->filename);
}

sub eval {
  my ($self, $context) = @_;

  my $class = $context->classes->{$self->name};

  unless ( $class ) {
    $class = Swig::Template::Runtime::Class->new;
    $context->class($self->name, $class);
  } 
  
  my $class_context = Swig::Template::Runtime::Context->new(current_self => $class, current_class => $class);
  $self->body->eval($class_context);

  return $class;
}

sub parse_file { 
  my ( $self, $file_name ) = shift; 
  if ( -e $file_name ) {
    my $raw_content = read_file($file_name);
    my ($abs_file_name) = $file_name =~ m/([^\/]+$)/g;
    $self->super_class($abs_file_name);
    return $raw_content;
  }
  croak "We found [$file_name] but can't find it";
}


no Moose; 1;
