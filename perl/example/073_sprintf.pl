#! /usr/bin/env perl
#################################################################################
#     File Name           :     073_sprintf.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 22:59]
#     Last Modified       :     [2018-06-20 23:14]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $s;

$s = sprintf("0x%02X", 255);
print $s, "\n";

$s = sprintf("%03d", 2);
print $s, "\n";

