#! /usr/bin/env perl
#################################################################################
#     File Name           :     025_execute_capture.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-29 20:15]
#     Last Modified       :     [2018-04-29 20:22]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @dir=`dir`;
my @ls=`ls`;

print "---------------------------------------------------------------------------\n";
print @dir;
print "---------------------------------------------------------------------------\n";
print @ls;
print "---------------------------------------------------------------------------\n";

print $#dir, "\n";
print $#ls, "\n";
print $dir[0];
print $dir[1];
print $dir[$#dir];
print $ls[0];
print $ls[1];
print $ls[$#ls];
# check the results of `ls` and `dir`


