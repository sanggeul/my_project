#! /usr/bin/env perl
#################################################################################
#     File Name           :     046_defined.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-19 01:55]
#     Last Modified       :     [2018-06-19 01:58]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @a = qw/ 123 3.14 666 /;
print $a[2], "\n";
print $a[3], "\n";


if (defined $a[3])
{
    print $a[3];
}

my $s;

if (defined $s)
{
    print "Okay, it's initiated\n";
}
else
{
    print "No, it's not initiated\n";
}


