#! /usr/bin/env perl
#################################################################################
#     File Name           :     /v/310/users/leesangg/sim/study/perl/refer.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-06 00:07]
#     Last Modified       :     [2018-04-06 00:07]
#     Description         :      
#################################################################################


use strict;
use warnings;

print "array exchange", "\n";
my @outer=("Sum", "Mercury", "Venus", undef, "Mars", "undef"); # undef makes warning
my @inner=("Earth", "Moon");

print '@outer : ' ,@outer, "\n";
print '@inner : ' ,@inner, "\n";

$outer[3]=@inner;

print '$outer[3] : ', $outer[3], "\n"; # 2, size of @inner
print '@outer : ', @outer, "\n"; # undef is changed to 2


print "\n";
print "scalar reference", "\n";
my $colour="Indigo";
my $scalarCop=$colour;
my $scalarRef=\$colour;

print '$colour : ', $colour, "\n";
print '$scalarCop : ', $scalarCop, "\n";
print '$scalarRef : ', $scalarRef, "\n";
print '${ $scalarRef } : ', ${$scalarRef}, "\n";
print '$$scalarRef : ', $$scalarRef, "\n";

print "\n";
print "array reference", "\n";
my @color=("Red", "Orange", "Yellow", "Green", "Blue", "Navy", "Violet") ;
my $ColorCop=@color;
my $ColorRef=\@color;

print '@Color : ', @color, "\n";
print '$ColorCop : ', $ColorCop, "\n";
print '$ColorRef : ', $ColorRef, "\n";
#print '${ $ColorRef } : ', ${$ColorRef}, "\n"; # error
#print '$$ColorRef : ', $$ColorRef, "\n"; # error
print '${ $ColorRef }[0] : ', ${$ColorRef}[0], "\n";
print '$$ColorRef[0] : ', $$ColorRef[0], "\n";
print '$ColorRef->[0] : ', $ColorRef->[0], "\n";
print '${ $ColorRef }[1] : ', ${$ColorRef}[1], "\n";
print '$$ColorRef[1] : ', $$ColorRef[1], "\n";
print '$ColorRef->[1] : ', $ColorRef->[1], "\n";


print "\n";
print "hash reference", "\n";
my %AtomicWeights=( "Hydrogen", 1.008, "Helium", 4.003, "Manganese", 54.94, );
my $HashRef=\%AtomicWeights;

print '$AtomicWeights{"Helium"} : ', $AtomicWeights{"Helium"}, "\n";
print '$HashRef : ', $HashRef, "\n";
print '${ $HashRef }{"Helium"} : ', ${ $HashRef }{"Helium"}, "\n";
print '$HashRef->{"Helium"} : ', $HashRef->{"Helium"}, "\n";


print "\n";
print "compare reference types", "\n";

print "type no.1", "\n";
my %owner11=(
            "name", "Santa Claus",
            "DOB"=> "1882-12-25",
        );
my $owner11Ref=\%owner11;

my %owner12=(
            "name", "Mickey Mouse",
            "DOB"=> "1928-11-18",
        );
my $owner12Ref=\%owner12;

my @owners1=( $owner11Ref, $owner12Ref );
my $owners1Ref=\@owners1;

my %account1=(
            "number"=> "1234568",
            "opened"=> "2000-01-01",
            "owners", $owners1Ref,
        );

print "type no.2", "\n";
my %owner21=(
            "name", "Santa Claus",
            "DOB"=> "1882-12-25",
        );
my %owner22=(
            "name", "Mickey Mouse",
            "DOB"=> "1928-11-18",
        );

my @owners2=( \%owner21, \%owner22);

my %account2=(
            "number"=> "1234568",
            "opened"=> "2000-01-01",
            "owners", \@owners2,
        );

print "type no.3", "\n";
my %owner31Ref=(
            "name", "Santa Claus",
            "DOB"=> "1882-12-25",
        );
my %owner32Ref=(
            "name", "Mickey Mouse",
            "DOB"=> "1928-11-18",
        );

my @owners3Ref=[ %owner31Ref, %owner32Ref ];

my %account3=(
            "number"=> "1234568",
            "opened"=> "2000-01-01",
            "owners", @owners3Ref,
        );

print "type no.4", "\n"; # best method !!
my %account4=(
            "number"=> "1234568",
            "opened"=> "2000-01-01",
            "owners", [
                {
                    "name", "Santa Claus",
                    "DOB"=> "1882-12-25",
                },
                {
                    "name", "Mickey Mouse",
                    "DOB"=> "1928-11-18",
                },
            ],
        );

#print
print '%account1 : ', %account1, "\n";
print '%account2 : ', %account2, "\n";
print '%account3 : ', %account3, "\n";
print '%account4 : ', %account4, "\n";

print '$account4{"number"} : ', $account4{"number"}, "\n";
print '$account4{"opened"} : ', $account4{"opened"}, "\n";
print '$account4{"owners"} : ', $account4{"owners"}, "\n";
print '\$account4{"owners"} : ', \$account4{"owners"}, "\n";
print '$account4{"owners"}->[0] : ', $account4{"owners"}->[0], "\n";
print '$account4{"owners"}->[1] : ', $account4{"owners"}->[1], "\n";
print '%{ $account4{"owners"}->[0] } : ', %{ $account4{"owners"}->[0] }, "\n";
print '%{ $account4{"owners"}->[1] } : ', %{ $account4{"owners"}->[1] }, "\n";
print '$account4{"owners"}->[0]->{"name"} : ', $account4{"owners"}->[0]->{"name"}, "\n";
print '$account4{"owners"}->[1]->{"name"} : ', $account4{"owners"}->[1]->{"name"}, "\n";
print '$account4{"owners"}->[0]->{"DOB"} : ', $account4{"owners"}->[0]->{"DOB"}, "\n";
print '$account4{"owners"}->[1]->{"DOB"} : ', $account4{"owners"}->[1]->{"DOB"}, "\n";


print "\n";
print "hash extraction", "\n";
my %account=(
            "number"=> "12345678",
            "opened"=> "2000-01-01",
            "owners", [
                {
                    "name", "Santa Claus",
                    "DOB"=> "1882-12-25",
                },
                {
                    "name", "Mickey Mouse",
                    "DOB"=> "1928-11-18",
                },
            ],
        );
print "Account #", $account{"number"}, "\n";
print "Opened on ", $account{"opened"}, "\n";
print "Joint owners: ", "\n";
print "\t", $account{"owners"}->[0]->{"name"};#,
    print " (born ", $account{"owners"}->[0]->{"DOB"}, ")\n"; # too long
print "\t", $account{"owners"}->[1]->{"name"};#,
    print " (born ", $account{"owners"}->[1]->{"DOB"}, ")\n"; # too long


