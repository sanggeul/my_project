#! /usr/bin/env perl
#################################################################################
#     File Name           :     098_string_to_array.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-27 22:27]
#     Last Modified       :     [2018-06-27 22:31]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $s = "MP3 Player";
my @array = unpack "C*", $s;

print chr($_), "-" foreach(@array);

print "\n";

my $result = pack "C*", @array;

print $result;
print "\n";


