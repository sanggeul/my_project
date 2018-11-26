#! /usr/bin/env perl
#################################################################################
#     File Name           :     048_join.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-19 22:59]
#     Last Modified       :     [2018-06-19 23:06]
#     Description         :      
#################################################################################

use strict;
use warnings;

# join <-> slpit
# string sum of array or add glue(delimiter)
# reurn string

my @a = qw/ apple man welcome ramen bao /;

my $s = join "/", @a;
print $s, "\n";

$_ = join "", @a;
print $_, "\n";

$_ = join ":", "apple", "is", "good";
print $_, "\n";

my $cool = " (^_^) ";
$_ = join $cool, "apple", "is", "good", @a;
print $_, "\n";

