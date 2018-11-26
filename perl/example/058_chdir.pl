#! /usr/bin/env perl
#################################################################################
#     File Name           :     058_chdir.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 01:17]
#     Last Modified       :     [2018-06-20 01:21]
#     Description         :      
#################################################################################

use strict;
use warnings;

use Cwd;

print getcwd, "\n";

chdir "/h/leesangg/" or die "Directory Error: $!\n";

print "Changed Dir Location: ", getcwd, "\n";

# When exit, location will be return to original location which is executed by perl

