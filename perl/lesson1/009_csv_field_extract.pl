#! /usr/bin/env perl
#################################################################################
#     File Name           :     009_csv_field_extract.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-15 18:53]
#     Last Modified       :     [2018-04-15 19:06]
#     Description         :      
#################################################################################

use strict;
use warnings;

&help if not defined $ARGV[0]; # if no option, print help

open FH, "<", $ARGV[0] or die "$!: '$ARGV[0]'\n";

my $separator = "\t";

my $n=0;

# decode option
if (defined $ARGV[1] && &IsInt($ARGV[1])) {
    $n = $ARGV[1] - 1;
    $n = 0 if ($n <= 0);
}

foreach (<FH>) {
    next if $_ =~ /^\s+$/; # check blank line
    @_ = split /$separator/; # check tab
    chomp @_; # remove \n in each element
    print $_[$n], "\n" if defined $_[$n]; # print Nth element
}

close(FH);

sub IsInt { # decimal, hexa, int -> ture
    ($_[0] =~ /^[+-]?\d+$|^0x[\da-fA-F]+$/)?1:0;
}

sub help {
    die <<TEXT;

    print N th field in data file that is separated by tab
    default 1

    optin number = filed

    Usage : 009_csv_field_extract.pl <file_name> [Field_Number]
    Example : 009_csv_field_extract.pl 009.txt 2

TEXT
}




