package RSP::Extension::Simple;

use Moose;
with 'RSP::Role::AppMutation';

use Moose::Util;

sub can_apply_mutations { 1 }

sub apply_mutations {
    my ($self, $config_obj) = @_;
    Moose::Util::apply_all_roles($config_obj->host_class, 'RSP::Role::SimpleConfig');
}

1;
