#! /usr/bin/env perl
#################################################################################
#     File Name           :     constructor.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-08 22:45]
#     Last Modified       :     [2018-04-09 19:52]
#     Description         :      
#################################################################################

use strict;
use warnings;

#require Animal;
require Demo::constructor;

my $constr = constructor->new();

print $constr->{"legs"}, "\n";
print $constr->{4}, "\n";
print $constr->{"colour"}, "\n";

#print "\n";
#print $constr->new("legs", 4, "colour", "brown");
#print "\n";
#print constructor::new($constr, "legs", 4, "colour", "brown");


