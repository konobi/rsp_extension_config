package RSP::Role::BasicConfig;

use Moose::Role;

sub extension_count {
    my ($self) = @_;
    return scalar(@{ $self->extensions });
}

1;
