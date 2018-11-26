#! /usr/bin/env perl
#################################################################################
#     File Name           :     061_tommorow_date.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 01:35]
#     Last Modified       :     [2018-06-20 01:37]
#     Description         :      
#################################################################################

use strict;
use warnings;

#my $rightnow = time - (24*60*60);
#my $rightnow = time
my $rightnow = time + (24*60*60);

printf ("tomorrow yy: %04d\n", (localtime $rightnow) [5] + 1900);
printf ("tomorrow mm: %02d\n", (localtime $rightnow) [4] + 1);
printf ("tomorrow dd: %02d\n", (localtime $rightnow) [3] );

