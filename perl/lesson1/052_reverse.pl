#! /usr/bin/env perl
#################################################################################
#     File Name           :     052_reverse.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-19 23:39]
#     Last Modified       :     [2018-06-19 23:41]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @a = qw/ aaa bbb ccc /;
print  "$_ " foreach @a;
print "\n";
@a = reverse @a;
print  "$_ " foreach @a;
print "\n";

my $a = "abcd";
print  "$_ " foreach $a;
print "\n";
$a = reverse $a;
print  "$_ " foreach $a;
print "\n";

