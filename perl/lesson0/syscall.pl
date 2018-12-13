#! /usr/bin/env perl
#################################################################################
#     File Name           :     /v/310/users/leesangg/sim/study/perl/syscall.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-06 00:08]
#     Last Modified       :     [2018-04-06 00:08]
#     Description         :      
#################################################################################


use strict;
use warnings;

my $rc1 = system "perl", "anotherscript.pl", "foo", "bar", "baz";
$rc1 >>= 8;
#$rc1 = $rc1 >> 8;
print $rc1;
print "\n";

my $rc2 = `perl anotherscript.pl foo bar baz`;
print $rc2;
print "\n";






