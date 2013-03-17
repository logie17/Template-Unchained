package Swig::Template;
our $VERSION = '0.01';
use Moose;
use Swig::Template::Parser;
use Swig::Template::Runtime::Context;

has html => ( is => 'rw', required => 1);
has data => ( is => 'rw');
has tree => ( is => 'rw');

sub render {
    my $self = shift;
    if ( my $tree = Swig::Template::Parser->parse($self->html) ) {
        $self->tree($tree);
        my $context = Swig::Template::Runtime::Context->new( locals => $self->data  );
        $self->html($tree->eval($context));
    }
    return $self;
}


__PACKAGE__->meta->make_immutable;

=head1 SYNOPSIS

    my $goodness = Swig::Template->run;

=head1 DESCRIPTION

Swig::Template
