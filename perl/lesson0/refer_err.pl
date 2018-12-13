#! /usr/bin/env perl
#################################################################################
#     File Name           :     /v/310/users/leesangg/sim/study/perl/refer_err.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-06 00:08]
#     Last Modified       :     [2018-04-06 00:08]
#     Description         :      
#################################################################################


use strict;
use warnings;

print 'array reference error', "\n";

print "\n";
my @arr1=(1, 2, 3, 4, 5,);

print '@arr1 : ', @arr1, "\n";

print "\n";
my @arr2=[1, 2, 3, 4, 5,];

#print '$arr2 : ', $arr2, "\n"; # error
print '@arr2 : ', @arr2, "\n";

print "\n";
my $arr3Ref=[1, 2, 3, 4, 5,];

print '$arr3Ref : ', $arr3Ref, "\n";
#print '@arr3Ref', @arr3Ref, "\n"; # error
print '@{ $arr3Ref } : ', @{ $arr3Ref }, "\n";
print '@$arr3Ref : ', @$arr3Ref, "\n";
print '$arr3Ref->[0] : ', $arr3Ref->[0], "\n"; # 1
print '$arr3Ref->[1] : ', $arr3Ref->[1], "\n"; # 2
print '$arr3Ref->[2] : ', $arr3Ref->[2], "\n"; # 3
print '$arr3Ref->[3] : ', $arr3Ref->[3], "\n"; # 4
print '$arr3Ref->[4] : ', $arr3Ref->[4], "\n"; # 5
print '$arr3Ref->[5] : ', $arr3Ref->[5], "\n"; # un-initialized






