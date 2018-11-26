#! /usr/bin/env perl
#################################################################################
#     File Name           :     023_subroutine.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-29 19:24]
#     Last Modified       :     [2018-04-29 19:35]
#     Description         :      
#################################################################################

use strict;
use warnings;

&foo0;
#foo0();

&foo1(1, 2);
&foo2(2, 3);
&foo3(3, 4);
print foo3(3, 4). "\n";
#&foo4;

sub foo0 {
    print "Hi, Good Moring\n";
}

sub foo1 {
    print $_[0] + $_[1], "\n";
}

sub foo2 {
    my $var1 = shift;
    my $var2 = shift;
    #my $var1 = shift@_;
    #my $var2 = shift@_;

    print $var1 + $var2, "\n";
}

sub foo3 {
    print $_[0] + $_[1], "\n";

    return 10000;
}


