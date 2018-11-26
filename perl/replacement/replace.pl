#! /usr/bin/env perl
#################################################################################
#     File Name           :     replace.pl
#     Created By          :     lesangge
#     Creation Date       :     [2018-11-14 07:13]
#     Last Modified       :     [2018-11-15 08:19]
#     Description         :      
#################################################################################

#print $#ARGV+1, "\n";
if ($#ARGV == -1) { die "There is no args.\n";}
if ($#ARGV != 3) {
	print "===========================================================","\n";
	print " \$ARGV[0] = input file ","\n";
	print " \$ARGV[1] = old word ","\n";
	print " \$ARGV[2] = new word ","\n";
	print " \$ARGV[3] = output file ","\n";
	print " Usage. ./replace.pl <input> <old_word> <new_word> <output>","\n";
	print " Ex.    ./replace.pl in.txt red blue out.txt","\n";
	die   "===========================================================","\n";
	}
for my $i ( 0 .. $#ARGV ) {
	print "ARGV\[",$i,"\] is ",$ARGV[$i],"\n";
}

my $input  = $ARGV[0];
my $old    = $ARGV[1];
my $new    = $ARGV[2];
my $output = $ARGV[3];

if ($input eq $output) {

	rename($input, $input.'.bak');
	open(IN, '<'.$input.'.bak') or die $!;
	open(OUT, '>'.$output) or die $!;
}
else {

	open(IN, '<'.$input) or die $!;
	open(OUT, '>'.$output) or die $!;
}

while(<IN>)
{
	$_ =~ s/$old/$new/g;
	print OUT $_;
}

close(IN);
close(OUT);


