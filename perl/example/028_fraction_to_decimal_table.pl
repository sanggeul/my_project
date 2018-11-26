#! /usr/bin/env perl
#################################################################################
#     File Name           :     028_fraction_to_decimal_table.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-29 21:57]
#     Last Modified       :     [2018-04-29 22:03]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $numerator;
my $denominator;

my $max = 10;

foreach $numerator ( 1 .. $max ) {
    foreach $denominator ( 1 .. $max ) {
        printf("%2d /%2d = %19.16f\n", $numerator, $denominator, $numerator/$denominator);
    }
}
