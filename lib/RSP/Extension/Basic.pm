package RSP::Extension::Basic;

use Moose;
with qw(RSP::Role::GlobalConfigManipulation);

sub apply_global_config_changes {
    my ($class, $config_obj) = @_;

    my $config_class = blessed($config_obj);
    Moose::Util::apply_all_roles($config_class->meta, 'RSP::Role::BasicConfig');
}

1;
