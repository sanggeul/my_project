#! /usr/bin/env perl
#################################################################################
#     File Name           :     012_pause_screen.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-17 23:46]
#     Last Modified       :     [2018-04-17 23:49]
#     Description         :      
#################################################################################

use strict;
use warnings;

print "Hello, I'm perl\n";
print "Press any Key to pass.\n";
my $i = <STDIN>;

print "Your input is $i\n";
print "Wait 10s\n";
sleep 10;

print "Press any Key to exit.\n";
my $i = <STDIN>;
print "Bye $i\n";




