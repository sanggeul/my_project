#! /usr/bin/env perl
#################################################################################
#     File Name           :     091_swap.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-25 22:35]
#     Last Modified       :     [2018-06-25 22:37]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $i = 300;
my $j = 500;

print '$i= ', $i, "\n";
print '$j= ', $j, "\n";

print "swap!!\n";
swap($i, $j);

print '$i= ', $i, "\n";
print '$j= ', $j, "\n";

sub swap
{
    ($_[0], $_[1]) = ($_[1], $_[0]);
}

