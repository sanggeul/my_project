#! /usr/bin/env perl
#################################################################################
#     File Name           :     067_uppercase_lowercase.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 04:13]
#     Last Modified       :     [2018-06-20 04:14]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $s = "AAA aaa Aaa";
print $s, "\n";

$s = uc($s);
print $s, "\n";

$s = lc($s);
print $s, "\n";

