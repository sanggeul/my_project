#! /usr/bin/env perl
#################################################################################
#     File Name           :     095_bit_fill.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-26 01:20]
#     Last Modified       :     [2018-06-26 01:25]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $num = 0;
printf("%016b\n", $num);

printf ("%016b\n", setAbit($num, 0, 1));
printf ("%016b\n", setAbit($num, 1, 1));
printf ("%016b\n", setAbit($num, 8, 1));
printf ("%016b\n", setAbit($num, 9, 1));

print "\n";
$num = 0;
foreach my $i (reverse 0 .. 15)
{
    my $temp = setAbit($num, $i, 1);
    printf("%016b = %10u\n", $temp, $temp);
}

print "\n";
$num = 0xffff;
foreach my $i (reverse 0 .. 15)
{
    my $temp = setAbit($num, $i, 0);
    printf("%016b = %10u\n", $temp, $temp);
}

sub setAbit
{
    my $x = shift;
    my $n = shift;
    my $b = shift;

    return $x | (1 << $n) if ($b == 1);
    return $x & (~(1 << $n));
}


