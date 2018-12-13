#! /usr/bin/env perl
#################################################################################
#     File Name           :     024_hash.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-29 20:09]
#     Last Modified       :     [2018-04-29 20:13]
#     Description         :      
#################################################################################

use strict;
use warnings;

my %cities = ("korea" => "seoul",
              "japan" => "tokyo",
              "usa" => "washington",
              "france" => "paris",
          );

print $cities{"usa"}, "\n";


my @countries = keys %cities;
my @capitals = values %cities;
my $count = keys %cities;


print @countries, "\n";
print @capitals, "\n";
print $count, "\n";


