package Template::Unchained;
our $VERSION = '0.01';
use Moose;
use Template::Unchained::Parser;
use Template::Unchained::Runtime::Context;

has html => ( is => 'rw', required => 1);
has data => ( is => 'rw');
has tree => ( is => 'rw');

sub render {
    my $self = shift;
    if ( my $tree = Template::Unchained::Parser->parse($self->html) ) {
        $self->tree($tree);
        my $context = Template::Unchained::Runtime::Context->new( locals => $self->data  );
        $self->html($tree->eval($context));
    }
    return $self;
}

__PACKAGE__->meta->make_immutable;

=head1 SYNOPSIS

    my $goodness = Template::Unchained->run;

=head1 DESCRIPTION

Template::Unchained
