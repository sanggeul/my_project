#! /usr/bin/env perl
#################################################################################
#     File Name           :     013_char_replace.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-18 01:15]
#     Last Modified       :     [2018-04-18 01:36]
#     Description         :      
#################################################################################

use strict;
use warnings;

print "Replace char 0\n";
$_ = "Hello, I'm Tom.\n";
print "$_\n";
s/Tom/Terry/;
print "$_\n";


print "Replace char 1\n";
my $i = "Hello, He is a man.\n";
print "$i\n";
$i =~ s/man/father/;
print "$i\n";

print "Add char\n";
my $t = "Hi Tom\n";
print "$t\n";
$t =~ s/(Tom)/$1 and James/;
print "$t\n";

print "Change char position\n";
my $tt = "Hi Jerry\n";
print "$tt\n";
$tt =~ s/(Hi).*(Jerry)/$2 $1/;
print "$tt\n";

print "Replace char 2\n";
my $ii = "Hello Tom Tom Tom Tom Tom Tom Tom Tom Tom.\n";
print "$ii\n";
$ii =~ s/Tom/Leon/;
print "$ii\n";
$ii =~ s/Tom/Leon/g;
print "$ii\n";

