#! /usr/bin/env perl
#################################################################################
#     File Name           :     /v/310/users/leesangg/sim/study/perl/list.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-06 00:07]
#     Last Modified       :     [2018-04-06 00:07]
#     Description         :      
#################################################################################


use strict;
use warnings;


print "list with array test", "\n";
my @arr=(
        "apple",
        "banana",
        (
            "inner"  ,
            "list"   ,
            "several",
            "entries",
      # ) ## inner brackets need comma ","
        ),
        "cherry",
        );

print @arr, "\n";
#print $arr, "\n"; # error
print $arr[0], "\n"; # apple
print $arr[1], "\n"; # banana
print $arr[2], "\n"; # inner
print $arr[3], "\n"; # list
print $arr[4], "\n"; # several
print $arr[5], "\n"; # entries
print $arr[6], "\n"; # cherry
print $arr[7], "\n"; # un-initialized


print "\n";
print "list with hash test", "\n";
my %has=(
        "apple", "5",
        "banana", "6", # No. 1
        #"banana",      # No. 2
        (
            "inner"  ,  "1",
            "list"   ,  "2",
            "several"=> "3",
            "entries"=> "4",
      # ) ## inner brackets need comma ","
        ),
        "cherry"=> "9",
        );
#print @has, "\n"; # error
#print $has, "\n"; # error
print %has, "\n"; # order will be changed
print $has{apple},     "\n"; # 5
print $has{5},         "\n"; # 5
print $has{banana},    "\n"; # 6
print $has{6},         "\n"; # 6
print $has{inner},     "\n"; # 1
print $has{1},         "\n"; # 1
print $has{list},      "\n"; # 2
print $has{2},         "\n"; # 2
print $has{several},   "\n"; # 3
print $has{3},         "\n"; # 3
print $has{"entries"}, "\n"; # 4
print $has{"4"},       "\n"; # 4
print $has{"cherry"},  "\n"; # 9
print $has{"9"},       "\n"; # 9

my %hah=(
        "apple", "5",
        #"banana", "6", # No. 1
        "banana",      # No. 2
        (
            "inner"  ,  "1",
            "list"   ,  "2",
            "several"=> "3",
            "entries"=> "4",
      # ) ## inner brackets need comma ","
        ),
        "cherry"=> "9",
        );
#print @hah, "\n"; # error
#print $hah, "\n"; # error
print %hah, "\n"; # order will be changed
print $hah{apple},     "\n"; # 5
print $hah{5},         "\n"; # 5
print $hah{banana},    "\n"; # 6
#print $hah{6},         "\n"; # 6
print $hah{inner},     "\n"; # 1
print $hah{1},         "\n"; # 1
print $hah{list},      "\n"; # 2
print $hah{2},         "\n"; # 2
print $hah{several},   "\n"; # 3
print $hah{3},         "\n"; # 3
print $hah{"entries"}, "\n"; # 4
print $hah{"4"},       "\n"; # 4
print $hah{"cherry"},  "\n"; # 9
print $hah{"9"},       "\n"; # 9
# warning because it has 7 elements

print "\n";
print "sum of array", "\n";
my @bones=("humerus", ("jaw", "skull"), "tribia");
my @fingers=("thumb", "index", "middle", "ring", "little");
my @parts=("eyeball", @bones, ("foot", "toes", ), @fingers, "knuckle");

print @bones, "\n";
print @fingers, "\n";
print @parts, "\n";

