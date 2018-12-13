#! /usr/bin/env perl
#################################################################################
#     File Name           :     022_split.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-25 01:25]
#     Last Modified       :     [2018-04-25 01:39]
#     Description         :      
#################################################################################

use strict;
use warnings;

# split $_ and store it to @_
$_ = "a bb ccc dddd eeeee ffff ggg hh i zz";
#@_ = split;
@_ = split / /, $_;
#@_ = split $_; # abnormal
&DumpArray(@_);

# use variable foo
my $foo = "1 22 333 4444 55555 6666 777 88 99 0";
my @foo = split / /, $foo;
&DumpArray(@foo);

# divide by comma
my $foo2 = "1, 2, 3, 4, 5, 6, 7, a, b, c, d, e";
my @foo2 = split /,/, $foo2;
&DumpArray(@foo2);

sub DumpArray {
    printf "Array Total Elements: %d\n", $#_ + 1;
    foreach my $i ( 0 .. $#_ ) {
        printf "[%d] = \"$_[$i]\"\n", $i;
    }
}

