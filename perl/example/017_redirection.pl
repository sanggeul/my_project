#! /usr/bin/env perl
#################################################################################
#     File Name           :     /v/310/users/leesangg/sim/study/perl/example/017_redirection.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-23 19:05]
#     Last Modified       :     [2018-04-23 19:08]
#     Description         :      
#################################################################################

use strict;
use warnings;

print "Gooooooooooooooooogle\n";

# ./017_redirection.pl > 017.txt

open FH, ">", "017.txt" or die "$!\n";

print FH "MicrooooooooooooooSoft\n";

close FH;


