#! /usr/bin/env perl
#################################################################################
#     File Name           :     100_hex_to_ascii.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-27 23:16]
#     Last Modified       :     [2018-06-27 23:20]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $hex = "41 70 70 6C 65"; # Apple
print hexToString($hex), "\n";

$hex = "0x41 0x70 0x70 0x6C 0x65"; # Apple
print hexToString($hex), "\n";

sub hexToString
{
    my @a = split(/\s/, $_[0]);
    my $result = "";

    foreach (@a)
    {
        $result .= chr(hex($_));    
    }

    return $result;
}

