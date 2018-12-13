#! /usr/bin/env perl
#################################################################################
#     File Name           :     097_bit_count.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-27 22:20]
#     Last Modified       :     [2018-06-27 22:26]
#     Description         :      
#################################################################################

use strict;
use warnings;

my ($num, $c);

$num = 0;
$c = countAbits($num);
printf("%016b = %10u : [1s = %2d] [0s = %2d]\n", $num, $num, $c, 16-$c);

$num = 1;
$c = countAbits($num);
printf("%016b = %10u : [1s = %2d] [0s = %2d]\n", $num, $num, $c, 16-$c);

$num = 0xff;
$c = countAbits($num);
printf("%016b = %10u : [1s = %2d] [0s = %2d]\n", $num, $num, $c, 16-$c);

$num = 0xffff;
$c = countAbits($num);
printf("%016b = %10u : [1s = %2d] [0s = %2d]\n", $num, $num, $c, 16-$c);

$num = 0b10101010101010;
$c = countAbits($num);
printf("%016b = %10u : [1s = %2d] [0s = %2d]\n", $num, $num, $c, 16-$c);

$num = 0b010101010101010;
$c = countAbits($num);
printf("%016b = %10u : [1s = %2d] [0s = %2d]\n", $num, $num, $c, 16-$c);

$num = 61547;
$c = countAbits($num);
printf("%016b = %10u : [1s = %2d] [0s = %2d]\n", $num, $num, $c, 16-$c);

sub countAbits
{
    my $x = shift;
    my $count = 0;

    while($x != 0)
    {
        $x &= $x -1;
        $count++;
    }

    return $count; 
}

