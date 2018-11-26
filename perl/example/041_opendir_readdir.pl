#! /usr/bin/env perl
#################################################################################
#     File Name           :     040_array_to_string.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-18 23:51]
#     Last Modified       :     [2018-06-19 00:03]
#     Description         :      
#################################################################################

use strict;
use warnings;

opendir(DIR, ".") or die "$!\n";
my @items = readdir(DIR);
closedir DIR;

foreach (sort @items)
#foreach (@items)
{
    # omit . ..
    next if $_ =~ /^\.\.?$/;
    # omit directory
    next unless (-f $_);

    print $_, "\n";
}



