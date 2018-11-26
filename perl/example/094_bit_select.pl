#! /usr/bin/env perl
#################################################################################
#     File Name           :     094_bit_select.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-26 01:13]
#     Last Modified       :     [2018-06-26 01:19]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $num = 24761;
printf("%016b\n", $num);

printf("%d\n", getAbit($num, 0));
printf("%d\n", getAbit($num, 1));

foreach my $i (reverse 0 .. 15)
{
    printf("%d", getAbit($num, $i));
}
print "\n";

sub getAbit # getbit() # getbit()
{
    return ($_[0] & (1 << $_[1])) >> $_[1];
}


