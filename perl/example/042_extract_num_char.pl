#! /usr/bin/env perl
#################################################################################
#     File Name           :     042_extract_num_char.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-19 00:07]
#     Last Modified       :     [2018-06-19 00:10]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $str = "She's gone, I am back. Bye. Welcome back. Come 2 me";

my @arr = $str =~ /\d+|[a-z|A-Z]+/g;

print $_, "\n" foreach(@arr);



