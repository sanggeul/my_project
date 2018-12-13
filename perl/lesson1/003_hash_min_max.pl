#! /usr/bin/env perl
#################################################################################
#     File Name           :     003_hash_min_max.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-10 19:46]
#     Last Modified       :     [2018-04-10 20:23]
#     Description         :      
#################################################################################
#################################################################################

use strict;
use warnings;

my %score=(
    "apple", 30,
    "mango", 0,
    "banana", 65,
    "berry", 98,
    "peach", 50,
);

print "Max: ", &GetHashMax(%score), "\n";
print "Min: ", &GetHashMin(%score), "\n";

sub GetHashMax {
    #print %_, "\n"; # empty
    #print @_, "\n"; # input hash
    %_ = @_;
    #print %_, "\n"; # array -> hash
    @_ = sort {$_{$b} <=> $_{$a}} keys %_;
    my $res = shift;
    #print @_, "\n"; # input hash
    print %_, "\n"; # empty
    #return ($res);
    return ($res, " ", $_{$res});
    #return (%_{$res});
}

sub GetHashMin {
    %_ = @_;
    @_ = sort {$_{$a} <=> $_{$b}} keys %_;
    my $res = shift @_;
    return ($res, " ", $_{$res});
}


