#! /usr/bin/env perl
#################################################################################
#     File Name           :     060_full_path.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 01:26]
#     Last Modified       :     [2018-06-20 01:34]
#     Description         :      
#################################################################################

use strict;
use warnings;

use Cwd;
use Cwd 'abs_path';

print getcwd, "\n";

my $full_path = abs_path("060_full_path.pl");
print "$full_path\n";

