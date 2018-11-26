#! /usr/bin/env perl
#################################################################################
#     File Name           :     102_press_one_key.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-28 18:36]
#     Last Modified       :     [2018-06-28 19:32]
#     Description         :      
#################################################################################

use strict;
use warnings;

use Term::ReadKey;
# didn't tested

print "press any key\n";

my $k = getAkey();

print "\nyou pressed [$k]\n";


sub getAkey
{
    ReadMode 'cbreak';
    my $key = ReadKey(0);
    print $key;
    ReadMode 'normal';

    return lc($key);
}

