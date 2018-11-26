#! /usr/bin/env perl
#################################################################################
#     File Name           :     005_array_initialize.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-11 22:36]
#     Last Modified       :     [2018-04-11 22:41]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @foo0=("test", "test2", "foo", "bar");
my @foo1 = qw/ testt testt2 fooo barr /;

foreach my $i (0 .. $#foo0) {
    print $i, ": ", $foo0[$i], "\n";
}

foreach (@foo1) {
    print $_, "\n";
}


