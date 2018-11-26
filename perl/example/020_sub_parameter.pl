#! /usr/bin/env perl
#################################################################################
#     File Name           :     020_sub_parameter.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-24 02:03]
#     Last Modified       :     [2018-04-24 22:33]
#     Description         :      
#################################################################################

use strict;
use warnings;

&foo(123, "ABC");

&num_test(2, 3);

&bar(1.32, "kaka");

sub foo {
    print "first parameter: ", $_[0], "\n";
    print "second parameter: ", $_[1], "\n";
}

sub num_test {
    print $_[0] + $_[1], "\n";
}

sub bar {
    $_ = shift@_;
    print "first parameter: ", $_, "\n";

    $_ = shift@_;
    print "second parameter: ", $_, "\n";
}

