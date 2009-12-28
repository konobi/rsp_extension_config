package RSP::Config::Host;

use Moose;
use List::MoreUtils qw(uniq);

has _parent => (is => 'ro', isa => 'RSP::Config', required => 1, init_arg => 'parent');
has _config => (is => 'ro', isa => 'HashRef', required => 1, init_arg => 'config');
has extensions => (is => 'ro', isa => 'ArrayRef', lazy_build => 1);
sub _build_extensions {
    my ($self) = @_;
    my $str = $self->_config->{extensions};
    my @exts = split(/,/, $str);
    return [ uniq(@{ $self->_parent->extensions }, @exts) ];
}

1;
