#! /usr/bin/env perl
#################################################################################
#     File Name           :     033_2_dimension_array.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-05-02 04:22]
#     Last Modified       :     [2018-05-02 04:29]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @AoA = (
    ["0_0", "0_1"],
    ["1_0", "1_1"],
    ["2_0", "2_1"],
);

print $AoA[0][0], "\n";
print $AoA[1][1], "\n";
print $AoA[2][0], "\n";
print @AoA, "\n";

my $x = 2;
my $y = 1;
print $AoA[$x][$y], "\n";

$AoA[10][10] = "10_100";
print $AoA[10][10], "\n";

$AoA[10][10] = "10_10";
print $AoA[10][10], "\n";

print $AoA[8][8], "\n";
# it's possible to make array that has un-initialized value




