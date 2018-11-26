#! /usr/bin/env perl
#################################################################################
#     File Name           :     038_sort_number.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-18 23:08]
#     Last Modified       :     [2018-06-18 23:12]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @foo = qw/ 24 6523.01 9857 51 2 43 90 2 0 0.0 636.62 /;

@foo = sort @foo;
print $_, "\n" foreach (@foo);

print "\n-------------------\n";

@foo = reverse sort @foo;
print $_, "\n" foreach (@foo);

print "\n-------------------\n";

@foo = sort {$a <=> $b} @foo;
print $_, "\n" foreach (@foo);

print "\n-------------------\n";

@foo = sort {$b <=> $a} @foo;
print $_, "\n" foreach (@foo);

print "\n-------------------\n";

@foo = reverse sort {$a <=> $b} @foo;
print $_, "\n" foreach (@foo);




