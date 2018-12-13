#! /usr/bin/env perl
#################################################################################
#     File Name           :     /v/310/users/leesangg/sim/study/perl/file.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-06 00:07]
#     Last Modified       :     [2018-04-06 00:07]
#     Description         :      
#################################################################################


use strict;
use warnings;

system `cp temp_old.txt temp.txt`;
my $f0="text.txt";
my $result0=open my $fh0, "<",$f0;

if(!$result0) {
    #die "Couldn't open '".$f0."' for reading because: ".$!; # program is finished
    print "Couldn't open '".$f0."' for reading because: ".$!;
    print "\n";
} else {
    print $result0, " is here.";
    print "\n";
}

print '$f0      : ', "$f0     ", "\n";
print '$result0 : ', "$result0", "\n";
print '$fh0     : ', "$fh0    ", "\n";
print '$!       : ', "$!      ", "\n";

my $f1="temp.txt";
my $result1=open my $fh1, "<",$f1;

if(!$result1) {
    #die "Couldn't open '".$f1."' for reading because: ".$!;
    print "Couldn't open '".$f1."' for reading because: ".$!; # program is finished
    print "\n";
} else {
    print $result1, " is here.";
    print "\n";
}

print '$f1      : ', "$f1     ", "\n";
print '$result1 : ', "$result1", "\n";
print '$fh1     : ', "$fh1    ", "\n";
print '$!       : ', "$!      ", "\n";

# short expression
#open(my $fh2, "<", $f0) || die "Coudln't open '".$f0."' for reading because: ".$!;
#open(my $fh3, "<", $f1) || die "Coudln't open '".$f1."' for reading because: ".$!;
open(my $fh2, "<", $f0) || print "Coudln't open '".$f0."' for reading because: ".$!."\n";
open(my $fh3, "<", $f1) || print "Coudln't open '".$f1."' for reading because: ".$!."\n";

# for test
open(my $fh4, "<", $f1) || print "Coudln't open '".$f1."' for reading because: ".$!."\n";
open(my $fh5, "<", $f1) || print "Coudln't open '".$f1."' for reading because: ".$!."\n";
open(my $fh6, "<", $f1) || print "Coudln't open '".$f1."' for reading because: ".$!."\n";
open(my $fh7, "<", $f1) || print "Coudln't open '".$f1."' for reading because: ".$!."\n";
open(my $fh8, "<", $f1) || print "Coudln't open '".$f1."' for reading because: ".$!."\n";

while(1) {
    my $line = readline $fh1;
    last unless defined $line; # last line + 1 -> exit
    # processthe line
    print $line;
    #print chomp $line;

    #$line = chomp $line;
    #print $line;
    # what is chomp ??? # it returns 1 or 0
}
print "\n";

# readline returns one line of text file
my $line = readline $fh3;
print $line;
$line = readline $fh3;
print $line;
$line = readline $fh3;
print $line;
$line = readline $fh3; # un-initialized
print $line;

$line = chomp $line;
print $line;

print "\n"; 

# normal expression
while (!eof $fh4) {
    my $line = readline $fh4;
    # process $line ...
    print $line;
}
print "\n"; 

# dangerous style
while (my $line = readline $fh5) {
    # process $line ...
    print $line;
}
print "\n"; 

# safe style
while (my $line = <$fh5>) {
    # process $line ...
    print $line;
}
print "\n"; 

# safe short style
while (<$fh6>) {
    # process $line ...
    print $_;
}
print "\n"; 


print "\n"; 
print "file write test"; 
print "\n"; 

system `cp temp.txt temp_old.txt`;
open(my $fh10, ">", $f1) || die "Couldn't open '".$f1."' for writing because: ".$!;
print $fh10 "The eagles have left the nest";
print $fh10 "\n";
close $fh10;
print `cat temp.txt`;


print "\n";
my $input=<STDIN>;
print $input;
print "\n";

print "\n"; 
print "check file test. -x\n"; 
print "-e : file name\n"; 
print "-d : directory\n"; 
print "-f : normal file\n"; 
print "need more study about -x !!!!!"; 
print "\n"; 

print "1_what\n" if -e "/usr/bin/perl";
print "2_what\n" unless -e "/usr/bin/perl";
print "3_array.pl\n" if -e "./array.pl";
print "4_array.pl\n" unless -e "./array.pl";
# -e, -d, -f, -x






