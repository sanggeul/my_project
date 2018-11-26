#! /usr/bin/env perl
#################################################################################
#     File Name           :     099_binary_string_to_hex.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-27 22:36]
#     Last Modified       :     [2018-06-27 23:14]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @bytes = (0x41, 0x20, 0x00, 0x01, 0x02, 0xff);
my $s = pack "C*", @bytes;

if (isPrintableString($s))
{
    print $s, "\n";
}
else
{
    print stringToHex($s), "\n";
}

$s = "Apple";

if (isPrintableString($s))
{
    print $s, "\n";
}
else
{
    print stringToHex($s), "\n";
}

$s = "super man 3 2 1";

if (isPrintableString($s))
{
    print $s, "\n";
}
else
{
    print stringToHex($s), "\n";
}

sub isPrintableString
{
    my @a = unpack "C*", $_[0];

    foreach (@a)
    {
        next if ($_ == 0x0a || $_ == 0x0d || $_ == 0x09);
        return 0 if ($_ < 0x20 || $_ > 0x7e); # available keyboard input
    }

    return 1;
}

sub stringToHex
{
    my @a = unpack "C*", $_[0];
    my $s = "";

    foreach (@a)
    {
        $s .= sprintf("%02X ", $_);
    }

    return $s;
}

