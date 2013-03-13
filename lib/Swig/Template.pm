package Swig::Template;
our $VERSION = '0.01';
use Moose;
use Swig::Template::Parser;
use Swig::Template::Runtime;

has html => ( is => 'rw', required => 1);
has tree => ( is => 'rw');

sub render {
    my $self = shift;
    if ( my $tree = Swig::Template::Parser->parse($self->html) ) {
        $self->tree($self->_render($tree));
    }
    return $self;
}

sub _render {
    my ($self, $tree) = @_;
    return $tree;
}


__PACKAGE__->meta->make_immutable;

=head1 SYNOPSIS

    my $goodness = Swig::Template->run;

=head1 DESCRIPTION

Swig::Template
