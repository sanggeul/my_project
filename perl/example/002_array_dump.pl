#! /usr/bin/env perl
#################################################################################
#     File Name           :     002_array_dump.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-10 19:09]
#     Last Modified       :     [2018-04-10 19:44]
#     Description         :      
#################################################################################

use strict;
use warnings;

&DumpArray(@ARGV);

sub DumpArray {
    print @_, "\n";
    printf "Array Total Elements: %d\n", $#_ + 1;
    printf "Array Total Elements: %d\n", scalar @_;
    print "Array Total Elements: ", scalar @_, "\n";

    foreach my $i (@_) {
        #print $i, " = ", $_[$i], "\n";
        print $i, "\n"; # $i <= each @_ element
        # $i is element
    }

    # it expression is better than above expression to me
    foreach my $i (0 .. $#_) {
        print $i, " = ", $_[$i], "\n";
        # $i is index
    }

}

