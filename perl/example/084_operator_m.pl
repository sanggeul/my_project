#! /usr/bin/env perl
#################################################################################
#     File Name           :     084_operator_m.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-25 00:05]
#     Last Modified       :     [2018-06-25 00:08]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $s = "tom orders apples from market.";


if ($s =~ /apple/)
{
    print " found apple\n";
}

if ($s =~ m/tom/)
{
    print " found tom\n";
}

if ($s =~ m^tom^)
{
    print " found tom\n";
}
