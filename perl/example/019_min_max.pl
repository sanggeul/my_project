#! /usr/bin/env perl
#################################################################################
#     File Name           :     019_min_max.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-23 23:36]
#     Last Modified       :     [2018-04-24 02:03]
#     Description         :      
#################################################################################

use strict;
use warnings;

#use List::Util qw/ min max /;
use List::Util ("min", "max");

my @foo=(12, 91, 1, -88, 4, 7, 25, 305, 10, 9934, 6553,  -35, 0, 10);

print "Min: ", min(@foo), "\n"; 
print "Max: ", max(@foo), "\n"; 

