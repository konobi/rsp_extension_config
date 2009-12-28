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

has extensions => (is => 'ro', isa => 'ArrayRef', lazy_build => 1);
sub _build_extensions {
    my ($self) = @_;
    my $extensions_string = $self->_config->{extensions};
    return [ split(/,/, $extensions_string) ];
}

has hosts => (is => 'ro', isa => 'HashRef', lazy_build => 1);
sub _build_hosts {
    my ($self) = @_;

    my $hosts = {};
    for my $h (keys %{ $self->_config->{host}}){
        my $opts = $self->_config->{host}{$h};

        $hosts->{$h} = RSP::Config::Host->new({ 
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
