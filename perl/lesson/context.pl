#! /usr/bin/env perl
#################################################################################
#     File Name           :     /v/310/users/leesangg/sim/study/perl/context.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-06 00:07]
#     Last Modified       :     [2018-04-06 00:07]
#     Description         :      
#################################################################################


use strict;
use warnings;

my $scal="Mendeleev";

my @arr=("Alpha", "Beta", "Gamma", "Pie");
my %has=("Alpha", "Beta", "Gamma", "Pie");
my %hah=("Alpha"=> "Beta", "Gamma"=> "Pie");

my @arr2=("Mendeleev");
my $scal2=("Alpha", "Beta", "Gamma", "Pie"); # Alpha, Beta, Gamma are void

my $scal3=@arr;

print '$scal : ',  $scal,  "\n"; # Mendeleev
print '@arr : ',   @arr,   "\n"; # Alpha Beta Gamma Pie
print '%has : ',   %has,   "\n"; # Gamma Pie Alpha Beta
print '%hah : ',   %hah,   "\n"; # Gamma Pie Alpha Beta
print '@arr2 : ',  @arr2,  "\n"; # Mendeleev
print '$scal2 : ', $scal2, "\n"; # Pie, others are void
print '$scal3 : ', $scal3, "\n"; # 4, size of @arr

print '""', "\n"; # text between ' and ' is showed as itself





