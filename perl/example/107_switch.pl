#! /usr/bin/env perl
#################################################################################
#     File Name           :     107_switch.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-07-03 20:13]
#     Last Modified       :     [2018-07-03 20:15]
#     Description         :      
#################################################################################

use strict;
use warnings;

use Switch;

my $choice = "A";

switch ($choice)
{
    case "A"    { print "'A'\n";}
    case 999    { print "999\n";}
    case "app"  { print "app\n";}
    else        { print "nop\n";}
}

