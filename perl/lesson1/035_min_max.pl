#! /usr/bin/env perl
#################################################################################
#     File Name           :     035_min_max.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-05-07 22:43]
#     Last Modified       :     [2018-05-07 22:47]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @n = qw / 36 3646453454.31 134 634 72.8 -356 5021525 0.00 77 86 /;

print "Min Value: ", &getMin(@n), "\n"; 
print "Max Value: ", &getMax(@n), "\n"; 


sub getMin {
    my $min = $_[0];
    
    foreach my $i ( 1 .. $#_ ) {
        $min = $_[$i] if ($_[$i] < $min);
    }
    return $min;
}

sub getMax {
    my $max = $_[0];
    
    foreach my $i ( 1 .. $#_ ) {
        $max = $_[$i] if ($_[$i] > $max);
    }
    return $max;
}







