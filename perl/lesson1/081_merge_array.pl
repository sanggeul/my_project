#! /usr/bin/env perl
#################################################################################
#     File Name           :     081_merge_array.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-21 00:46]
#     Last Modified       :     [2018-06-21 00:48]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @a = qw/ aaa bbb ccc ddd eee /;
my @b = qw/ 100 200 300 400 500 /;

push @a, @b;

print "$_" foreach @a;

print "\ncheck again\n";
foreach my $i (0 .. $#a)
{
    print "\$a[$i] = $a[$i]\n";
\n";
}




