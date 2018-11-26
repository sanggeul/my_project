#! /usr/bin/env perl
#################################################################################
#     File Name           :     059_yesterday_date.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 01:22]
#     Last Modified       :     [2018-06-20 01:25]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $rightnow = time - (24*60*60);

printf ("yesterday yy: %04d\n", (localtime $rightnow) [5] + 1900);
printf ("yesterday mm: %02d\n", (localtime $rightnow) [4] + 1);
printf ("yesterday dd: %02d\n", (localtime $rightnow) [3] );

