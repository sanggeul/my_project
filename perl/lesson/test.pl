#! /usr/bin/env perl
#################################################################################
#     File Name           :     /v/310/users/leesangg/sim/study/perl/test.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-06 00:09]
#     Last Modified       :     [2018-04-06 00:09]
#     Description         :      
#################################################################################


use strict;
use warnings;

my @arr= (("a")x10, ("b")x5);
my @arr2= ("a","a","a","a","a","a","a","a","a", );
print @arr, "\n";
print $arr[1], "\n";
print @arr2, "\n";
print join(", ", @arr), "\n";
print join(", ", @arr2), "\n";
