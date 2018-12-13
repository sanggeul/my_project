#! /usr/bin/env perl
#################################################################################
#     File Name           :     051_shift_unshift_pop_push.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-19 23:27]
#     Last Modified       :     [2018-06-19 23:34]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @a;
my $s;

@a  = qw/ apple basic calc drain effective /;

# shift
print "$_ " foreach @a;
print "\n";
$s = shift @a;
print $s, "\n";
print "$_ " foreach @a;
print "\n";

# unshift
unshift @a, "APPLE";
print "$_ " foreach @a;
print "\n";

# pop
$s = pop @a;
print $s, "\n";
print "$_ " foreach @a;
print "\n";

# push
push @a, "EFFECTIVE";
print "$_ " foreach @a;
print "\n";


