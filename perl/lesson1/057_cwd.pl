#! /usr/bin/env perl
#################################################################################
#     File Name           :     057_cwd.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 01:14]
#     Last Modified       :     [2018-06-20 01:15]
#     Description         :      
#################################################################################

use strict;
use warnings;

use Cwd;

print getcwd, "\n";
my $current = getcwd();

print $current, "\n";

