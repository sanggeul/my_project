#! /usr/bin/env perl
#################################################################################
#     File Name           :     072_day_of_this_year.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 22:39]
#     Last Modified       :     [2018-06-20 22:40]
#     Description         :      
#################################################################################

use strict;
use warnings;

printf ("Today is [%d]th day of this year.\n", (localtime)[7]+1);

