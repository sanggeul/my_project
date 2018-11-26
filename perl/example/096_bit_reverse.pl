#! /usr/bin/env perl
#################################################################################
#     File Name           :     096_bit_reverse.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-27 22:12]
#     Last Modified       :     [2018-06-27 22:19]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $num = 0xFF;
printf("Original Num: %016b\n", $num);

foreach my $i (0 .. 15)
{
    my $temp = reverseAbit($num, $i);
    printf("[%2d-th bit toggle] %016b = %10u\n", $i, $temp, $temp);
}

print "\n";

sub reverseAbit
{
    my $x = shift;
    my $n = shift;

    return $x ^= (1 << $n);
}


