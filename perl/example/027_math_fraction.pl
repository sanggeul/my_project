#! /usr/bin/env perl
#################################################################################
#     File Name           :     027_math_fraction.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-29 21:50]
#     Last Modified       :     [2018-04-29 21:55]
#     Description         :      
#################################################################################

use strict;
use warnings;

use Math::Fraction;
=put
need to install the Math:Fraction Module fisrt
This perl script cannot be executed.
=cut

my $x;
my $pn = 1.14285714285;
my $f1 = 1;
my $f2 = 3;

print "----- change prime number to fraction -----\n";
print "pn is $pn\n";
$x = frac($pn);
print "x is $x\n";

print "----- change fraction to prime number -----\n";
print "f1, f2 are $f1, $f2\n";
$x = frac($f1, $f2);
print "x is $x\n";

