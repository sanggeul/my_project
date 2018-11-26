#! /usr/bin/env perl
#################################################################################
#     File Name           :     106_infinite_loop_last.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-07-03 20:09]
#     Last Modified       :     [2018-07-03 20:12]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $stopper;
$stopper = 0;
print "stopper: [$stopper]\n";

for (;;) # infinite loop
{
    print "<infinite loop>\n";
    
    $stopper++;;
    print "stopper: [$stopper]\n";
    if ($stopper >= 10)
    {
        last;
    }
}
        
