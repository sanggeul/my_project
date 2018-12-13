#! /usr/bin/env perl
#################################################################################
#     File Name           :     054_count_char.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-19 23:52]
#     Last Modified       :     [2018-06-19 23:57]
#     Description         :      
#################################################################################

use strict;
use warnings;

&help if ($#ARGV < 1);

my $count = 0;
my $search = $ARGV[0];

open IN, "<", "$ARGV[1]" or die "$ARGV[1] : $!\n";

while (<IN>)
{
    while (/$search/gi)
    {
        $count++;
    }
}

print "'$search': $count Time(s) mateched\n";

close IN;


sub help
{
    die <<TEXT;

    Count of matched Word or Regec (v0.01)

        Usage:
            name.pl word <filename>
            name.pl regex <filename>

        Example:
            name.pl foo <filename>
            name.pl \\d+ <filename>

TEXT
}


