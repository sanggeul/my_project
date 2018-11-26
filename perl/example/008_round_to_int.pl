#! /usr/bin/env perl
#################################################################################
#     File Name           :     008_round_to_int.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-15 18:18]
#     Last Modified       :     [2018-04-15 18:28]
#     Description         :      
#################################################################################

use strict;
use warnings;

print "2.333  : ", &RoundToInt(2.333), "\n";
print "2.433  : ", &RoundToInt(2.433), "\n";
print "2.533  : ", &RoundToInt(2.533), "\n";
print "2.633  : ", &RoundToInt(2.633), "\n";

sub RoundToInt {

    print "Input: ", @_, "\n";
    int($_[0] + .5 * ($_[0] <=> 0));

}


#
# Also use
#use POSIX qw(ceil floor);
#    or 
#Math::Round
#
