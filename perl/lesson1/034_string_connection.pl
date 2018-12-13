#! /usr/bin/env perl
#################################################################################
#     File Name           :     034_string_connection.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-05-02 04:33]
#     Last Modified       :     [2018-05-02 04:35]
#     Description         :      
#################################################################################

use strict;
use warnings;

print "Apple" . "Pie", "\n";
print "Apple" . " " . "Pie", "\n";

my $str = "Apple" . " " . "Pie";
print $str, "\n";

print $str . " " . $str, "\n";



