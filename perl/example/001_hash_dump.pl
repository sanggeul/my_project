#! /usr/bin/env perl
#################################################################################
#     File Name           :     001_hash_dump.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-10 18:52]
#     Last Modified       :     [2018-04-10 19:09]
#     Description         :      
#################################################################################

use strict;
use warnings;

my %city = (
    "Korea" => "Seoul",
    "Japan" => "Tokyo",
    "Greece"    => "Athens",
    "America"   => "Washington",
    "France"    => "Paris",
);

&DumpHash(%city);

sub DumpHash {
    %_ = @_;
    print "Number of items: ", scalar keys(%_), "\n";
    foreach my $key (sort keys %_) {
        print "\"$key\" => \"$_{$key}\"\n";
    }
}

