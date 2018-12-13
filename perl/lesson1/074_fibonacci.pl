#! /usr/bin/env perl
#################################################################################
#     File Name           :     074_fibonacci.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 23:14]
#     Last Modified       :     [2018-06-20 23:17]
#     Description         :      
#################################################################################

use strict;
use warnings;

use bigint;

my $a=0;
my $b=1;
my $temp;

#foreach my $n (0 .. 300)
foreach my $n (0 .. 30)
{
    print $a, "\n";

    $temp = $a;
    $a    = $b;
    $b    = $temp+$b;
}
