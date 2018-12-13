#! /usr/bin/env perl
#################################################################################
#     File Name           :     015_next_if.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-23 18:51]
#     Last Modified       :     [2018-04-23 18:56]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @foo = ( "babo", "man", "woman", "bigshow", "winxp", "jam", "win98", "doll" );

# informal
foreach (@foo) {
    next if $_ =~ /\d/;
    print $_, "\n";
}

print "\n";

#formal
foreach (@foo) {
    if ($_ =~ /\d/) {next;}
    print $_. "\n";
}

