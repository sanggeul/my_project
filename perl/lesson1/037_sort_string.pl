#! /usr/bin/env perl
#################################################################################
#     File Name           :     037_sort_string.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-18 23:02]
#     Last Modified       :     [2018-06-18 23:06]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @foo = (
            "hacker",
            "crackekr",
            "apple",
            "tripple",
            "amazon",
            "iphone",
            "melon",
            "genie",
            "durian",
          );

@foo = sort @foo;
print $_, "\n" foreach (@foo);

print "\n\n\n-------------------\n\n\n";

@foo = reverse sort @foo;
print $_, "\n" foreach (@foo);



