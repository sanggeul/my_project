#! /usr/bin/env perl
#################################################################################
#     File Name           :     043_sort_hash.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-19 00:24]
#     Last Modified       :     [2018-06-19 00:35]
#     Description         :      
#################################################################################

use strict;
use warnings;

my %cities = (
    "Korea"  => "Seoul",
    "Japan"  => "Tokyo",
    "Greece" => "Athens",
    "USA"    => "Washington",
    "France" => "Paris",
);


print "\n <key sorting> \n";
foreach $_ (sort keys %cities)
{
    print "$_ : $cities{$_}\n";
}


print "\n <vaule sorting> \n";
foreach $_ (sort { $cities{$a} cmp $cities{$b} } keys %cities)
{
    print "$_ : $cities{$_}\n";
}


my %num = (
    4343   => 4,
    88     => 1215,
    0.1    => -12,
    1212.1 => 124.0,
    542.0  => 54,
    542.2  => 0,
    42.1   => 1,
    87     => 99,
);


print "\n <key sorting wrong> \n";
foreach $_ (sort keys %num)
{
    print "$_ : $num{$_}\n";
}

print "\n <key sorting> \n";
foreach $_ (sort {$a <=> $b} keys %num)
{
    print "$_ : $num{$_}\n";
}

print "\n <vaule sorting> \n";
foreach $_ (sort { $num{$a} <=> $num{$b} } keys %num)
{
    print "$_ : $num{$_}\n";
}

