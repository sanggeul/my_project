#! /usr/bin/env perl
#################################################################################
#     File Name           :     083_extract_string_2.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-21 01:29]
#     Last Modified       :     [2018-06-21 01:34]
#     Description         :      
#################################################################################

use strict;
use warnings;

# didn't tested

use utf8;

open IN,  "<:encoding(UTF-8)", "083_in.html";
open OUT, ">:encoding(UTF-8)", "083_out.txt";

my @in = <IN>; # @in <-- open IN
chomp @in;

my ($title, $link);

foreach (@in)
{
    if (/<div style="margin-bottom:3px;"><a href=".*">(.*)<\/a><\/div>/)
    {
        $title = $1;
        print OUT $title, "\n";
    }

    if (/<div style="margin-bottom:3px;"><a href="(.*)"/)
    {
        $link = $1;
        print OUT $link, "\n\n";
    }
}

close IN; close OUT;

