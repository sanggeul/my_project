#! /usr/bin/env perl
#################################################################################
#     File Name           :     062_sort_case_sensitive.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 01:41]
#     Last Modified       :     [2018-06-20 01:43]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @foo = (
            "hacker",
            "crackekr",
            "APPLE",
            "tripple",
            "AMAZON",
            "IPHONE",
            "melon",
            "GENIE",
            "durian",
          );

@foo = sort @foo;
print $_, "\n" foreach (@foo);

print "\n-------------------\n";

@foo = reverse sort @foo;
print $_, "\n" foreach (@foo);

print "\n-------------------\n";

@foo = sort { lc($a) cmp lc($b) } @foo;
print $_, "\n" foreach (@foo);

print "\n-------------------\n";

@foo = reverse sort { lc($a) cmp lc($b) } @foo;
print $_, "\n" foreach (@foo);



