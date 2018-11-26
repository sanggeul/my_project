#! /usr/bin/env perl
#################################################################################
#     File Name           :     /v/310/users/leesangg/sim/study/perl/repeat.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-06 00:08]
#     Last Modified       :     [2018-04-10 19:30]
#     Description         :      
#################################################################################


use strict;
use warnings;

print "\n";
print "repeat test", "\n";
my @array=(7, 6, 3, "a", "b", );
print scalar @array, "\n";
print $#array, "\n";
print 'scalar @array = $#array + 1', "\n";

print "\n";
print "(1) while", "\n";

my $i=0;
while ($i < scalar @array) {
    print $i, ": ", $array[$i], "\t";
    $i++;
}
print "\n";

$i=0;
while ($i < $#array) {
    print $i, ": ", $array[$i], "\t";
    $i++;
}
print "\n";

print "\n";
print "(2) until", "\n";

my $j=0;
until ($j>=scalar @array) {
    print $j, ": ", $array[$j], "\t";
    $j++;
}
print "\n";

$j=0;
until ($j>=$#array) {
    print $j, ": ", $array[$j], "\t";
    $j++;
}
print "\n";


print "\n";
print "(3) do", "\n";

my $k=0;
do {
    print $k, ": ", $array[$k], "\t";
    $k++;
} while ($k < scalar @array);
print "\n";

$k=0;
do {
    print $k, ": ", $array[$k], "\t";
    $k++;
} while ($k < $#array);
print "\n";

$k=0;
do {
    print $k, ": ", $array[$k], "\t";
    $k++;
} until ($k >= scalar @array);
print "\n";

$k=0;
do {
    print $k, ": ", $array[$k], "\t";
    $k++;
} until ($k >= $#array);
print "\n";


print "\n";
print "(4) for / foreach", "\n";

# old style
for (my $s0=0; $s0<scalar @array; $s0++) {
    print $s0, ": ", $array[$s0], "\t";
} # valiable s0 is valid only in for loop
print "\n";

for (my $s0=0; $s0<scalar @array; $s0++) {
    print $s0, ": ", $array[$s0], "\t";
} # my $s0 is used two times, no error
print "\n";

foreach (my $s1=0; $s1<scalar @array; $s1++) {
    print $s1, ": ", $array[$s1], "\t";
}
print "\n";

# new style
foreach my $string ( @array ) {
    print "111", $string, "\t";
}
print "\n";

foreach my $s ( 0 .. $#array ) {
    print $s, ": ", $array[$s], "\t";
}
print "\n";

foreach my $s ( 0 .. $#array-1 ) {
    print $s, ": ", $array[$s], "\t";
}
print "\n";


my %person=(
           "Newton"=>"Isaac",
           "Einstein"=>"Albert",
           "Darwin", "Charles",
           );
foreach my $key (keys %person) {
    print $key, "\t";
    }
print "\n";

foreach my $key (keys %person) {
    print $key, ": ", $person{$key}, "\t";
    }
print "\n";

foreach my $key (sort keys %person) { # sorted by a-z
    print $key, ": ", $person{$key}, "\t";
    }
print "\n";

foreach my $key (sort keys %person) { # sorted by a-z
    print $key, "\t";
    }
print "\n";

foreach my $key (sort keys %person) { # sorted by a-z
    print $person{$key}, "\t";
    }
print "\n";
print "\n";

# foreach + if
foreach my $key (keys %person) {
    if ($key eq "Newton") {
        print $key, ": ", $person{$key}, "\n";
    } else {
        print $key, " is not Newton", "\n";
    }
}
print "\n";

foreach (@array) {
    print $_;
}
print "\n";

foreach my $g (@array) {
    print  $_;
    # $_ is used when iterator X
    # this statement generates warnings
}
print "\n";

print $_ foreach (@array);
print "\n";


print "\n";
print "repeat control, next/last", "\n";

# prime code
#CANDIDATE: foreach my $candidate ( 0 .. 100 ) {
#CANDIDATE: foreach my $candidate ( 0 .. 50 ) {
CANDIDATE: foreach my $candidate ( 2 .. 100 ) {
    foreach my $divisor ( 2 .. sqrt($candidate) ) {
        next CANDIDATE if $candidate % $divisor == 0;
    }
    print $candidate. " is prime \n";
}
print "\n";

