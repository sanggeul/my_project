#! /usr/bin/env perl
#################################################################################
#     File Name           :     076_rand_range.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 23:21]
#     Last Modified       :     [2018-06-20 23:25]
#     Description         :      
#################################################################################

use strict;
use warnings;

foreach my $i (1 .. 20)
{
    print randomRange(30,40), "\n";
}

sub randomRange
{
    my $n1 = shift;
    my $n2 = shift;

    return int( (rand() * ($n2 - $n1 + 1)) + $n1 );
}


