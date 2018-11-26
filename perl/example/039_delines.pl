#! /usr/bin/env perl
#################################################################################
#     File Name           :     039_delines.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-18 23:17]
#     Last Modified       :     [2018-06-18 23:27]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $count = 0;

while (<>) {
    if (/^\s*$/) {
        $count++;
        print $_ if ($count < 2);
    }
    else {
        $count = 0;
        print $_;
    }
}



