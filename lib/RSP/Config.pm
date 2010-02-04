package RSP::Config;

use Moose;

use Config::Any;
use RSP::Config::Host;

has _config => (is => 'ro', isa => 'HashRef', lazy_build => 1);
sub _build__config {
    my ($self) = @_;
    my $foo = Config::Any->load_files({ files => ['etc/rsp.conf'], force_plugins => ['Config::Any::INI'] });
    return $foo->[0]->{'etc/rsp.conf'};
}

has available_extensions => (is => 'ro', isa => 'ArrayRef', lazy_build => 1);
sub _build_available_extensions {
    my ($self) = @_;
    my $available_string = $self->_config->{available_extensions};
    return [ split(/,/, $available_string) ];
}

has extensions => (is => 'ro', isa => 'ArrayRef', lazy_build => 1);
sub _build_extensions {
    my ($self) = @_;
    my $extensions_string = $self->_config->{extensions};
    return [ split(/,/, $extensions_string) ];
}

has host_class => (is => 'ro', isa => 'Str', default => 'RSP::Config::Host');

has hosts => (is => 'ro', isa => 'HashRef', lazy_build => 1);
sub _build_hosts {
    my ($self) = @_;

    my $hosts = {};
    for my $h (keys %{ $self->_config->{host}}){
        my $opts = $self->_config->{host}{$h};

        $hosts->{$h} = $self->host_class->new({ 
            config => $opts,
            parent => $self,
        });
    }

    return $hosts;
}

sub host {
    my ($self, $host) = @_;
    return $self->hosts->{$host};
}

1;
