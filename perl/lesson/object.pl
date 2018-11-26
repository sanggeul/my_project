#! /usr/bin/env perl
#################################################################################
#     File Name           :     object.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-08 22:45]
#     Last Modified       :     [2018-04-09 01:13]
#     Description         :      
#################################################################################

use strict;
use warnings;

require Demo::Animal;

my $animal = {
            "legs", 4,
            "colour", "brown",
        };

print $animal, "\n";        
print ref $animal, "\n";        
bless $animal, "Animal";        
print ref $animal, "\n";

print "Animal has ", $animal->{"legs"}, " leg(s)\n"; # hash
$animal->eat("insect", "curry", "eucalyptus"); # method 1
Animal::eat($animal, "insect", "curry", "eucalyptus"); # method 2






