#! /usr/bin/env perl
#################################################################################
#     File Name           :     032_string_comparison.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-05-02 04:16]
#     Last Modified       :     [2018-05-02 04:20]
#     Description         :      
#################################################################################

use strict;
use warnings;

# eq compare
my $foo = "apple";

if ($foo eq "apple") {
    print "same words\n";
} else {
    print "not same words\n";
}

if ("foo" =~ /FOO/) {
    print "foo and FOO are the same\n";
} else {
    print "foo and FOO are not the same\n";
}

if ("foo" =~ /FOO/i) {
    print "foo and FOO are the same\n";
} else {
    print "foo and FOO are not the same\n";
}

my $bar = "sir";

if ($bar =~ /^sir$/) {
    print "same\n"
} else {
    print "not same\n"
}



