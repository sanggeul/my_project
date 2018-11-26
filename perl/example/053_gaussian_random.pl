#! /usr/bin/env perl
#################################################################################
#     File Name           :     053_gaussian_random.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-19 23:45]
#     Last Modified       :     [2018-06-19 23:49]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @a;

for (my $i = 1; $i <= 50; $i++)
{
    push @a, &gaussianRandom;
}


@a = sort {$a <=> $b} @a;
print $_, "\n" foreach @a;


sub gaussianRandom
{
    my ($v1, $v2, $s);

    do {
        $v1 = 2*rand()-1;
        $v2 = 2*rand()-1;
        $s  = $v1*$v1 + $v2*$v2;
    } while ($s >= 1 || $s == 0);

    $s = sqrt( (-2 * log($s)) / $s);

    return $v1 * $s;
}
