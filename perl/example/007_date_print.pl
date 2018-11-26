#! /usr/bin/env perl
#################################################################################
#     File Name           :     007_date_print.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-12 01:30]
#     Last Modified       :     [2018-04-12 01:39]
#     Description         :      
#################################################################################

use strict;
use warnings;

print "LocalTime     : ", (localtime), "\n";
print "LocalTime[0]  : ", (localtime)[0], "\n";
print "LocalTime[1]  : ", (localtime)[1], "\n";
print "LocalTime[2]  : ", (localtime)[2], "\n";
print "LocalTime[3]  : ", (localtime)[3], "\n";
print "LocalTime[4]  : ", (localtime)[4], "\n";
print "LocalTime[5]  : ", (localtime)[5], "\n";
print "LocalTime[6]  : ", (localtime)[6], "\n";
print "LocalTime[7]  : ", (localtime)[7], "\n";

print "Year  : ", &GetTimeStr("Y"), "\n";
print "Month : ", &GetTimeStr("M"), "\n";
print "Day   : ", &GetTimeStr("D"), "\n";


print "\n";

print "Hour : ", &GetTimeStr("h"), "\n";
print "Min  : ", &GetTimeStr("m"), "\n";
print "Sec  : ", &GetTimeStr("s"), "\n";

print &GetTimeStr("Y"), "/", &GetTimeStr("M"), "/", &GetTimeStr("D"), " ", 
      &GetTimeStr("h"), ":", &GetTimeStr("m"), ":", &GetTimeStr("s"), "\n";

sub GetTimeStr {

    return sprintf("%02d", (localtime)[0] ) if $_[0] eq "s";
    return sprintf("%02d", (localtime)[1] ) if $_[0] eq "m";
    return sprintf("%02d", (localtime)[2] ) if $_[0] eq "h";

    return sprintf("%02d", (localtime)[3]        ) if $_[0] eq "D";
    return sprintf("%02d", (localtime)[4] + 1    ) if $_[0] eq "M";
    return sprintf("%04d", (localtime)[5] + 1900 ) if $_[0] eq "Y";

    undef;
}
