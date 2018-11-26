#! /usr/bin/env perl
#################################################################################
#     File Name           :     004_line_print.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-11 19:55]
#     Last Modified       :     [2018-04-11 19:56]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $line=1;

while (<>) {
    print $line, ": ", $_;
    $line++
}

