#! /usr/bin/env perl
#################################################################################
#     File Name           :     090_remove_dupl_ignore_case.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-25 22:22]
#     Last Modified       :     [2018-06-25 22:32]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @names = qw/ Aa Bb Cc Dd Ee Ff Aa dD fF gg zz tt qq /;

print "$_ " foreach @names;
print "\n";

@names = uniqueElements(@names);
print "$_ " foreach @names;
print "\n";

sub uniqueElements
{
    my ($item, %seen, @result);

    foreach $item (@_)
    {
        push (@result, $item) unless $seen{lc($item)}++;
    }
    return @result;
}


