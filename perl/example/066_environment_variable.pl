#! /usr/bin/env perl
#################################################################################
#     File Name           :     066_environment_variable.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 02:24]
#     Last Modified       :     [2018-06-20 02:25]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $s = $ENV{"PATH"};
print $s, "\n";

foreach $_ (sort keys(%ENV))
{
    print "$_=$ENV{$_}\n";
}

