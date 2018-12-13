#! /usr/bin/env perl
#################################################################################
#     File Name           :     077_shuffle.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 23:42]
#     Last Modified       :     [2018-06-20 23:44]
#     Description         :      
#################################################################################

use strict;
use warnings;

use List::Util qw(shuffle);

my @a = <>;
chomp @a;

print "$_\n" foreach shuffle @a;



