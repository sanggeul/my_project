#! /usr/bin/env perl
#################################################################################
#     File Name           :     031_array_count.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-05-02 04:06]
#     Last Modified       :     [2018-05-02 04:08]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @names = qw/ aa bb cc dd ee ff gg hh ii jj kk ll mm nn /;

my $count = @names;
print $count, "\n";

my $count2 = scalar @names;
print $count2, "\n";

my $count3 = $#names;
print $count3, "\n";



