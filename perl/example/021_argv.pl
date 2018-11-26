#! /usr/bin/env perl
#################################################################################
#     File Name           :     021_argv.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-24 23:00]
#     Last Modified       :     [2018-04-25 01:24]
#     Description         :      
#################################################################################

use strict;
use warnings;

printf "All option count: %d\n", $#ARGV + 1;
print "All option array: [@ARGV]\n";

if ($#ARGV == -1) {die "No option.\n"; }

print "1st option: $ARGV[0]\n" if defined $ARGV[0];
print "2nd option: $ARGV[1]\n" if defined $ARGV[1];
print "3rd option: $ARGV[2]\n" if defined $ARGV[2];
print "4th option: $ARGV[3]\n" if defined $ARGV[3];
print "5th option: $ARGV[4]\n" if defined $ARGV[4];

