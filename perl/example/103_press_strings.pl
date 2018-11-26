#! /usr/bin/env perl
#################################################################################
#     File Name           :     103_press_strings.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-28 19:33]
#     Last Modified       :     [2018-06-28 19:35]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $s;

print "press any keys and enter\n";
$s = <STDIN>;
chomp($s);

if ($s)
{
    print "you typed [$s]\n";
}
else
{
    print "just enter\n";
}

