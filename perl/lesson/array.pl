#! /usr/bin/env perl
#################################################################################
#     File Name           :     array.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-06 00:06]
#     Last Modified       :     [2018-04-06 00:06]
#     Description         :      
#################################################################################


use strict;
use warnings;

my @arr=(
        #print,     #0
        "print",   #0
        "these",   #1
        "strings", #2
        "out",     #3
        "for",     #4
        "me",      #5
        );

print "\n";
print $arr[0]  , "\n";
print $arr[1]  , "\n";
print $arr[2]  , "\n";
print $arr[3]  , "\n";
print $arr[4]  , "\n";
print $arr[5]  , "\n";
print $arr[6]  , "\n"; # null

print "\n";
print $arr[-1]  , "\n"; # =5
print $arr[-2]  , "\n"; # =4
print $arr[-3]  , "\n"; # =3
print $arr[-4]  , "\n"; # =2
print $arr[-5]  , "\n"; # =1
print $arr[-6]  , "\n"; # =0
print $arr[-7]  , "\n"; # null

print "\n";
#print $arr, "\n"; # error
#print $@arr, "\n"; # error
print @arr, "\n";
print $#arr, "\n";
