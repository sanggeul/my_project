#! /usr/bin/env perl
#################################################################################
#     File Name           :     075_change_enter.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 23:18]
#     Last Modified       :     [2018-06-20 23:19]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $s = join "", <>;

$s =~ s/\n/,/g;

print $s, "\n";
