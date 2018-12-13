#! /usr/bin/env perl
#################################################################################
#     File Name           :     089_remove_dupl.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-25 22:15]
#     Last Modified       :     [2018-06-25 22:20]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @names = qw/ aa bb cc dd ee ff aa dd ff gg zz tt qq /;

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
        push (@result, $item) unless $seen{$item}++;
    }
    return @result;
}


