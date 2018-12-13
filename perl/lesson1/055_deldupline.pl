#! /usr/bin/env perl
#################################################################################
#     File Name           :     055_deldupline.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 01:08]
#     Last Modified       :     [2018-06-20 01:08]
#     Description         :      
#################################################################################

use strict;
use warnings;

foreach (<>)
{
    chomp;
    print "$_\n" unless $_{$_}++;
}


