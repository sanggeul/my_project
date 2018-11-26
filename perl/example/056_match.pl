#! /usr/bin/env perl
#################################################################################
#     File Name           :     056_match.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 01:11]
#     Last Modified       :     [2018-06-20 01:13]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $s = "Linux";

print "$s is matched 0\n" if $s =~ (/Linux/);
print "$s is matched 1\n" if $s =~ (/LINUX/);
print "$s is matched 2\n" if $s =~ (/LINUX/i);


