package RSP::Extension::Basic;

use Moose;
with qw(RSP::Role::AppMutation);

sub can_apply_mutations { return 1; }

sub apply_mutations {
    my ($class, $config_obj) = @_;

    my $config_class = blessed($config_obj);
    Moose::Util::apply_all_roles($config_class->meta, 'RSP::Role::BasicConfig');
}

1;
