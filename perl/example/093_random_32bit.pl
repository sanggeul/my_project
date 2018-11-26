#! /usr/bin/env perl
#################################################################################
#     File Name           :     093_random_32bit.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-25 23:22]
#     Last Modified       :     [2018-06-25 23:39]
#     Description         :      
#################################################################################

use strict;
use warnings;

print "hexa\t\tbinary\t\t\t\t\tunsigned_dec\tsigned_dec\n";
print "====================================================================================\n";
foreach my $i (1 .. 10)
{
    my $r32 = random32();
    printf("%08X\t%032b\t%10u\t(%11d)\n", $r32, $r32, $r32, $r32);
}

sub random32
{
    my $result = 0;

    foreach my $i (reverse 0 .. 31)
    {
        $result = setAbit($result, $i, int(rand(2)) );
    }
    return $result;
}

sub setAbit
{
    my $x = shift;
    my $n = shift;
    my $b = shift;

    return $x | (1 << $n) if ($b == 1);
    return $x & (~(1 << $n));
}


