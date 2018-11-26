#! /usr/bin/env perl
#################################################################################
#     File Name           :     018_round.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-23 23:24]
#     Last Modified       :     [2018-04-23 23:26]
#     Description         :      
#################################################################################

use strict;
use warnings;

print &RoundXL(42.444999999, 3);

sub RoundXL {
    sprintf("%.$_[1]f\n", $_[0]);
}

