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

    for my $ext (@{ $self->config->extensions }){
        my $class = "RSP::Extension::$ext";
        Class::MOP::load_class($class);

        if($class->does('RSP::Role::GlobalConfigManipulation')){
            $class->apply_global_config_changes( $self->config ); 
        }
    }

    print "Count is: ".$self->config->extension_count."\n";
}

sub app {
    my ($self, $host) = @_;
    
    my $host_obj = $self->config->host('foo');

    for my $ext (@{ $host_obj->extensions || [] }){
        my $class = "RSP::Extension::$ext";
        Class::MOP::load_class($class);

        if($class->does('RSP::Role::HostConfigManipulation')){
            $class->apply_host_config_changes( $host_obj );
        }
    }

    print "Host count is: ".$host_obj->host_extension_count."\n";

}

1;
