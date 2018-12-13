#! /usr/bin/env perl
#################################################################################
#     File Name           :     108_for_next.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-07-03 20:30]
#     Last Modified       :     [2018-07-03 20:35]
#     Description         :      
#################################################################################

use strict;
use warnings;

foreach my $i (0 .. 10)
#for (my $i=0; $i <= 10; $i++)
{
    if ($i == 5 || $i == 6)
    {
        next;
    }
    printf ("\$i = %3d\n", $i);
}

