package RSP::Extension::Advanced;

use Moose;
with 'RSP::Role::AppMutation';

use Moose::Util;

sub can_apply_mutations { 
    my ($self, $config_obj) = @_;
    
    # we require SimpleConfig Role on host config object
    if($config_obj->host_class->does('RSP::Role::SimpleConfig')){
        return 1;
    }

    return 0;
}

sub apply_mutations {
    my ($self, $config_obj) = @_;
    #Moose::Util::apply_all_roles($config_obj->host_class, 'RSP::Role::SimpleConfig');
}

1;
