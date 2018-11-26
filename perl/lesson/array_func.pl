#! /usr/bin/env perl
#################################################################################
#     File Name           :     /v/310/users/leesangg/sim/study/perl/array_func.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-06 00:06]
#     Last Modified       :     [2018-04-06 00:06]
#     Description         :      
#################################################################################


use strict;
use warnings;

print "\n";
print "array function test", "\n";

my @stack = ( "Fred ", "Eileen ", "Denise ", "Charlie " );
print @stack, "\n";

#pop, reture last element and remove it
print pop @stack, "\n";
print @stack, "\n";


#push, add elemment to last 
push @stack, "Bob ", "Alice ";
print @stack, "\n";

#shift, reture first element and remove it
print shift @stack, "\n";
print @stack, "\n";

#unshift, add elemment to last 
unshift @stack, "Hank ", "Grace ";
print @stack, "\n";

# pop, push, shif, unshift are special cases of splice

#print splice (@stack,   1,  4, "<<< ", "--- ", ">>> "), "\n";
#print splice (@stack,   1,  3, "<<< ", "--- ", "--- ", "--- ", "--- ", ">>> "), "\n";
print splice (@stack,   1,  3, ), "\n"; # just delete
#             array "from""to""new elements"
print @stack, "\n";

#join
my @elements=( "Antimony", "Arsenic", "Aluminum", "Selenium" );
print @elements, "\n";
print "@elements", "\n";
print join(", ", @elements), "\n";
print @elements, "\n";

#reverse
print reverse("Hello", "World"), "\n";
print reverse("HelloWorld"), "\n";
print scalar reverse("Hello", "World"), "\n";
print scalar reverse("HelloWorld"), "\n";

my @capitals=("Baton Rouge", "Indianapolis", "Columbus", "Montgomery", "Helena", "Denber", "Boise",);
print @capitals, "\n";
print join ", ", (map { uc $_ } @capitals), "\n";
print join ", ", (grep { length $_ == 6 } @capitals), "\n";
print scalar (grep { $_ eq "Columbus" } @capitals), "\n";

print "\n";
print "sort test", "\n";
my @elevations=(19, 1, 2, 100, 3, 89, 100, 1056, );
print join ", ", (sort @elevations), "\n"; # a to z

print join ", ", (sort { $a cmp $b } @elevations), "\n"; # a to z

print join ", ", (sort { $a <=> $b } @elevations), "\n"; # 1 to 9





