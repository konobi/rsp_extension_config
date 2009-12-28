package RSP::Role::SimpleConfig;

use Moose::Role;

sub host_extension_count {
    my ($self) = @_;

    return scalar(@{ $self->extensions });
}

1;
