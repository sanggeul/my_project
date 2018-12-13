#! /usr/bin/env perl
#################################################################################
#     File Name           :     regular.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-06 00:05]
#     Last Modified       :     [2018-04-08 21:42]
#     Description         :     Regular Expression Practice
#################################################################################

use strict;
use warnings;

print "regular expression";
print "\n";
print "\n";
print "(1) match operation";
print "\n";

my $string="Hello world";
if ($string =~ m/(\w+)\s+(\w+)/) {
    print "success\n";
}       
print 'uses =~ m/***/', "\n";
print '$string =~ m/(\w+)\s+(\w+)/', "\n";
print '\w+: word', "\n";
print '\s+: space', "\n";
print '\w+: word', "\n";
print '$1 : ', "$1\n"; 
print '$2 : ', "$2\n";
print '$3 : ', "$3\n";
       
my $strings="colourless green ideas sleep furiously";
#my @matches = $strings =~ m/(\w+)\s+(\w+)\s+(\w+)\s+(\w+)\s+(\w+)/;
#my @matches = $strings =~ m/(\w+)\s+((\w+)\s+(\w+))\s+(\w+)\s+(\w+)/;
my @matches = $strings =~ m/((\w+)\s+((\w+)\s+(\w+))\s+(\w+))\s+(\w+)/;

#print join ", ", map {";".$_.";"} @matches;
print join ", ", map {$_} @matches;
print "\n";
print '@matches : ', @matches, "\n";
print '$1       : ', $1      , "\n";
print '$2       : ', $2      , "\n";
print '$3       : ', $3      , "\n";
print '$4       : ', $4      , "\n";
print '$5       : ', $5      , "\n";
print '$6       : ', $6      , "\n";
print '$7       : ', $7      , "\n";
print '$8       : ', $8      , "\n";


print "\n";
print "(2) replace operation";
print "\n";

my $string1="Good morning world";
print $string1, "\n";
$string1 =~ s/world/Vietnam/;
print $string1, "\n";

print "\n";
print "(3) group matching";
print "\n";

my $string2="a tonne of feathers or a tonne of bricks";
while($string2 =~ m/(\w+)/g) {
    print "'".$1."'\n";
}

print "\n";
print "No while \n";
$string2="a tonne of feathers or a tonne of bricks";
$string2 =~ m/(\w+)/g;
print "'".$1."'\n";
$string2 =~ m/(\w+)/g;
print "'".$1."'\n";
$string2 =~ m/(\w+)/g;
print "'".$1."'\n";
$string2 =~ m/(\w+)/g;
print "'".$1."'\n";
$string2 =~ m/(\w+)/g;
print "'".$1."'\n";
$string2 =~ m/(\w+)/g;
print "'".$1."'\n";
$string2 =~ m/(\w+)/g;
print "'".$1."'\n";
$string2 =~ m/(\w+)/g;
print "'".$1."'\n";
$string2 =~ m/(\w+)/g;
print "'".$1."'\n";
$string2 =~ m/(\w+)/g;
print "'".$1."'\n";


print "\n";
print "No while w+x2 \n";
$string2="a tonne of feathers or a tonne of bricks";
$string2 =~ m/(\w+)\s+(\w+)/g;
print "'".$1."'\n";
print "'".$2."'\n";
$string2 =~ m/(\w+)\s+(\w+)/g;
print "'".$1."'\n";
print "'".$2."'\n";
$string2 =~ m/(\w+)\s+(\w+)/g;
print "'".$1."'\n";
print "'".$2."'\n";
$string2 =~ m/(\w+)\s+(\w+)/g;
print "'".$1."'\n";
print "'".$2."'\n";
$string2 =~ m/(\w+)\s+(\w+)/g;
print "'".$1."'\n";
print "'".$2."'\n";
$string2 =~ m/(\w+)\s+(\w+)/g;
print "'".$1."'\n";
print "'".$2."'\n";

print "\n";
# a/w/j/o/u -> r
$string2 =~ s/[awjou]/r/; # 1-time
print $string2;
print "\n";

$string2 =~ s/[awjou]/r/; # 1-time
print $string2;
print "\n";

$string2 =~ s/[awjou]/r/g; # all
print $string2;
print "\n";


"Hello world" =~ m/
        (\w+) # one or more word characters
        [ ]   # single lieral space, stored inside a character class
        world # iteral "world"
        /x;
print $1;
print $2;
print "\n";

"Hello world" =~ m/
        (\w+) # one or more word characters
        \s+   # single lieral space, stored inside a character class
        (\w+) # world # iteral "world"
        /x;
print $1;
print $2;
print "\n";



