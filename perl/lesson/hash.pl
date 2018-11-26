#! /usr/bin/env perl
#################################################################################
#     File Name           :     /v/310/users/leesangg/sim/study/perl/hash.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-06 00:07]
#     Last Modified       :     [2018-04-06 00:07]
#     Description         :      
#################################################################################


use strict;
use warnings;

my %person=(
           "Newton"=>"Isaac",
           "Einstein"=>"Albert",
           "Darwin", "Charles",
           # both => and , can be used
           );

print "\n";
print $person{"Newton"},    "\n"; # Isaac
print $person{"Einstein"},  "\n"; # Albert
print $person{"Einsteinn"}, "\n"; # un-initialized value
print $person{"Darwin"},    "\n"; # Charles

print %person, "\n";
my @person = %person;
print @person, "\n";
print %person, "\n"; # same with above %person, hash does't have order...?
#print $person, "\n"; # error

print "\n";
print "data scalar, array, hash test", "\n";
my $data = "orange";
my @data = ("blue");
my %data = ("6", "sun");

print $data,       "\n"; # orange
print @data,       "\n"; # blue
print $data[0],    "\n"; # blue
print $data["0"],  "\n"; # blue
print $data[-1],   "\n"; # blue
print $data["-1"], "\n"; # blue
print $data[1],    "\n"; # un-initialized
print $data["1"],  "\n"; # un-initialized
print $data{6},    "\n"; # sun
print $data{"6"},  "\n"; # sun
print $data{1},    "\n"; # un-initialized
print $data{"1"},  "\n"; # un-initialized




