#!/usr/bin/env perl

use strict;
use warnings;

use lib 'lib';

use RSP::App;

my $foo = RSP::App->new;

$foo->main; # should be 1
$foo->app("foo"); # should be 2

