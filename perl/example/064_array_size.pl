#! /usr/bin/env perl
#################################################################################
#     File Name           :     064_array_size.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 01:52]
#     Last Modified       :     [2018-06-20 01:53]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @a = qw/ aaa bbb ccc ddd eee fff /;

my $count = @a;

print @a, "\n";
print $count, "\n";
print scalar @a, "\n";
print $#a, "\n";

