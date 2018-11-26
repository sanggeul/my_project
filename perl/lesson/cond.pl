#! /usr/bin/env perl
#################################################################################
#     File Name           :     /v/310/users/leesangg/sim/study/perl/cond.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-06 00:06]
#     Last Modified       :     [2018-04-06 00:06]
#     Description         :      
#################################################################################


use strict;
use warnings;

print "length test", "\n";
my $word="antidisestablishmentarianism";
#my $strlen=length('http://perdoc.perl.org/functions/length.html');
my $strlen=length($word);
#my $strlen=length $word;

print '$strlen', $strlen, "\n";
if ($strlen>=15) {
    print "'", $word, "' is a very long word", "\n";
} elsif (10<=$strlen && $strlen<15) {
    print "'", $word, "' is a medium-length word", "\n";
} else {
    print "'", $word, "' is a short word", "\n";
}


print ";", $word, "' is actually enormous", "\n" if $strlen >= 20; # print
print ";", $word, "' is actually enormous", "\n" if $strlen >= 30; # no print


print "unless test", "\n";
my $temperature=20;

unless ($temperature>30) {
    print $temperature, " degrees Celsius is not very hot", "\n";
} else {
    print $temperature, " degrees Celsius is actually pretty hot", "\n";
} # unless is not recommanded

print "Oh no it's too cold", "\n" unless $temperature > 15;
print "Oh no it's too cold", "\n" unless $temperature > 25;

print "\n";
print "operator test", "\n";

my $gain=48;
print "You gained ", $gain, " ", ($gain==1?"experience point":"experience points"), "!\n";

my $lost=1;
print "You lost ", $lost, " t", ($lost==1?"oo":"ee"), "th!\n";

my $eggs=5;
print "You have ", $eggs==0?"no eggs":
                   $eggs==1?"an egg" :
                   "some eggs", "\n";

my $val="gg";
my @arr=(9, 2, "c", undef, "d", );

print "1\n";
# in 1 case, there are some un-expected results
# if use "(" or ")", operator expression have not to be located at first
print ($val?"val ture":"val false"), "\n";
print ($val == "gg"?"val is gg":"val is not gg"), "!\n";
print ($val == "zz"?"val is zz":"val is not zz"), "!\n";
print ($val eq "gg"?"val is gg":"val is not gg"), "!\n";
print ($val eq "zz"?"val is zz":"val is not zz"), "!\n";
print (@arr?"arr ture":"arr false"), "\n";
print "\n";

print "2\n";
print $val?"val ture":"val false", "\n";
print $val == "gg"?"val is gg":"val is not gg", "!\n";
print $val == "zz"?"val is zz":"val is not zz", "!\n";
print $val eq "gg"?"val is gg":"val is not gg", "!\n";
print $val eq "zz"?"val is zz":"val is not zz", "!\n";
print @arr?"arr ture":"arr false", "\n";

print "3\n";
print "", @arr[0]==9?"arr[0] is 9":"arr[0] is not 9", "\n";
print "", $val?"val ture":"val false", "\n";
print "", ($val == "gg"?"val is gg":"val is not gg"), "!\n";
print "", ($val == "zz"?"val is zz":"val is not zz"), "!\n";
print "", ($val eq "gg"?"val is gg":"val is not gg"), "!\n";
print "", ($val eq "zz"?"val is zz":"val is not zz"), "!\n";
print "", @arr?"arr ture":"arr false", "\n";
print "", @arr[0]==9?"arr[0] is 9":"arr[0] is not 9", "\n";







