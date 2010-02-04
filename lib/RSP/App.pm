package RSP::App;

use Moose;

use RSP::Config;

has config => (is => 'ro', isa => 'Object', lazy_build => 1);
sub _build_config {
    my ($self) = @_;
    return RSP::Config->new;
}


sub main {
    my ($self) = @_;

    my @extension_stack = @{ $self->config->available_extensions };
    my $unable_to_comply = {};

    while(my $ext = shift(@extension_stack)){
        my $class = "RSP::Extension::$ext";
        Class::MOP::load_class($class);

        if($class->does('RSP::Role::AppMutation')){
            warn "Attempting to apply mutations on $ext\n";
            if($class->can_apply_mutations($self->config)){
                $class->apply_mutations($self->config);
            } else {
                push(@extension_stack, $ext);
                my $tries = ++$unable_to_comply->{$class};
                if($unable_to_comply > scalar(@extension_stack)){
                    die "Unable to apply extension mutations";
                }
            }
        } else {
            warn "$ext does not do AppMutation";
        }
    }

    print "Count is: ".$self->config->extension_count."\n";
}

sub app {
    my ($self, $host) = @_;
    
    my $host_obj = $self->config->host('foo');

    print "Host count is: ".$host_obj->host_extension_count."\n";
}

1;
