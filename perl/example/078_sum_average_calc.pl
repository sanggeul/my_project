#! /usr/bin/env perl
#################################################################################
#     File Name           :     078_sum_average_calc.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 23:46]
#     Last Modified       :     [2018-06-20 23:54]
#     Description         :      
#################################################################################

use strict;
use warnings;

use List::Util qw( sum );

my @a = qw/ 22 5 46 6 0 1 55 /;

print sum_(@a), "\n";     # make sub
print average_(@a), "\n"; # make sub

print sum(@a), "\n";      # call use func

sub sum_
{
    my $result = 0.0;

    foreach my $i (0 .. $#_)
    {
        $result += $_[$i];
    }

    return $result;
}

sub average_
{
    return "NaN" if ($#_ < 0);

    my $result = 0.0;

    foreach my $i (0 .. $#_)
    {
        $result += $_[$i];
    }

    return $result / ($#_ + 1);

}
