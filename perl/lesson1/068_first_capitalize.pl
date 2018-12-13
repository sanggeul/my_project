#! /usr/bin/env perl
#################################################################################
#     File Name           :     068_first_capitalize.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 04:15]
#     Last Modified       :     [2018-06-20 04:16]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $s = "GOOGLE";
print $s, "\n";

$s = "\u\L$s";
print $s, "\n";

$s = "\u\LgooGLE";
print $s, "\n";


