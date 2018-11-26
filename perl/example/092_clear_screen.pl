#! /usr/bin/env perl
#################################################################################
#     File Name           :     092_clear_screen.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-25 22:38]
#     Last Modified       :     [2018-06-25 22:56]
#     Description         :      
#################################################################################

use strict;
use warnings;

clearScreen();

sub clearScreen
{
    if ($^O eq 'MSWin32')
    {
        system("cls");
        print "system cls\n";
    }
    else
    {
        system("clear");
        print "system clear\n";
    }
}

