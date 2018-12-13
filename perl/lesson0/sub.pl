#! /usr/bin/env perl
#################################################################################
#     File Name           :     /v/310/users/leesangg/sim/study/perl/sub.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-06 00:08]
#     Last Modified       :     [2018-04-06 00:08]
#     Description         :      
#################################################################################


use strict;
use warnings;

# user defined sub-routine
# uses sub
# input is scalar
# factor uses @_

sub hyphenate {
    print scalar @_; # size of array
    print "\n";
    print $#_; # last index
    print "\n";
    my $word=shift;
    my $word2=shift;
    print $word, "\n";
    print $word2, "\n";

    #my $word=shift @_;
    #my $word=$_[0];
    #my $word=$_[1];
    #my $word=splice (@_, 0, 1);
    # get first element and remove others

    # An overly clever list comprehension
    $word=join "-", map { substr $word, $_, 1 } ( 0 .. (length $word) - 1 );
    return $word;
}

print hyphenate("exterminate", "abcdefg");
print "\n";
print hyphenate(123456789, "abcdefg");
print "\n";
print hyphenate("exterminate", "abcdefg", 12345);
print "\n";
print hyphenate();
print "\n";


print "\n";
print "use of factors";
print "\n";

# print left_pad_n("hello", 10, "+");

sub left_pad_0 {
    my $newString=($_[2] x ($_[1] - length $_[0])) . $_[0];
    return $newString;
} # bad

sub left_pad_1 {
    my $oldString=$_[0];
    my $width=$_[1];
    my $padChar=$_[2];
    my $newString=($padChar x ($width - length $oldString)) . $oldString;
    return $newString;
}

sub left_pad_2 {
    my $oldString=shift @_;
    my $width=shift @_;
    my $padChar=shift @_;
    my $newString=($padChar x ($width - length $oldString)) . $oldString;
    return $newString;
}

sub left_pad_3 {
    my $oldString=shift;
    my $width=shift;
    my $padChar=shift;
    my $newString=($padChar x ($width - length $oldString)) . $oldString;
    return $newString;
} # good ?

sub left_pad_4 {
    my ($oldString, $width, $padChar)=@_;
    my $newString=($padChar x ($width - length $oldString)) . $oldString;
    return $newString;
}

print left_pad_0("hello", 10, "+");
print "\n";
print left_pad_1("hello", 15, "+");
print "\n";
print left_pad_2("hello", 20, "+");
print "\n";
print left_pad_3("hello", 25, "+");
print "\n";
print left_pad_4("hello", 30, "+");
print "\n";

sub left_pad_5 {
    my %args=@_;
    my $newString=($args{"padChar"} x ($args{"width"} - length $args{"oldString"})) . $args{"oldString"};
    return $newString;
}

print left_pad_5("oldString", "hello", "width", 35, "padChar", "+");
print "\n";


print "\n";
print "results return";
print "\n";

sub contextualSubroutine {
    # want array
    return ("Everest", "K2", "Enta") if wantarray;

    # want scalar
    return 7;
}

my @array=contextualSubroutine();
print @array;
print "\n";

my $array=contextualSubroutine();
print $array;
print "\n";


