package RSP::Extension::Simple;

use Moose;
with 'RSP::Role::HostConfigManipulation';

use Moose::Util;

sub apply_host_config_changes {
    my ($self, $host_obj) = @_;
    Moose::Util::apply_all_roles($host_obj, 'RSP::Role::SimpleConfig');
}

1;
