#! /usr/bin/env perl
#################################################################################
#     File Name           :     110_timer.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-07-04 00:27]
#     Last Modified       :     [2018-07-04 00:42]
#     Description         :      
#################################################################################

use strict;
use warnings;

codeTimer("on");
print "Timer is on\n";

print "Press the Enter key to stop Timer\n";
<STDIN>;

print "Time takes.... " . codeTimer("off") . "\n";


{
    my $old_time;
    sub codeTimer
    {
        if ($_[0] eq "on" ) { $old_time = time(); }
        if ($_[0] eq "off") { secToHHMMSS(time() - $old_time); }
    }
}

sub secToHHMMSS
{
    my ($hour, $min, $sec);

    $sec  = $_[0] % 60;
    $min  = $_[0] / 60 % 60;
    $hour = $_[0] / 3600;

    sprintf "%02d:%02d:%02d", $hour, $min, $sec;
}

