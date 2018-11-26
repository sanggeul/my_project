#! /usr/bin/env perl
#################################################################################
#     File Name           :     109_reference_pointer.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-07-04 00:14]
#     Last Modified       :     [2018-07-04 00:20]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @a = qw/ apple pearl google oracle /;

my $r = \@a;
print $r, "\n";

print join("/", @{$r}), "\n";
print join("/", @$r), "\n";
print join(">>", @{$r}), "\n";
print join(">>", @$r), "\n";

print ${$r}[0], "\n";
print ${$r}[1], "\n";
print ${$r}[2], "\n";
print ${$r}[3], "\n";
print ${$r}[4], "\n";

print $$r[0], "\n";
print $$r[1], "\n";
print $$r[2], "\n";
print $$r[3], "\n";
print $$r[4], "\n";

print_array(@{$r});
print "\n";

print_array2(\@a);
print "\n";

sub print_array
{
    print "[$_] " foreach (@_);
}

sub print_array2
{
    my $temp = shift;
    print "<$_> " foreach (@{$temp});
}



