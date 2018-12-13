#! /usr/bin/env perl
#################################################################################
#     File Name           :     xml_to_sfr.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-09 00:29]
#     Last Modified       :     [2018-08-01 20:19]
#     Description         :     xml (from excel) to sfr (verilog) generation
#                               type : ro, rw, wo, w1c
#################################################################################

use strict;
use warnings;

use XML::LibXML;
use Switch;
#use String::Util qw(trim);

# from argv: module_name, sfr_fn, xml_flie

my $parser = XML::LibXML->new;
#my $spx = $parser->parse_file("xml/spa_regdef_t.xml") or die;
my $spx = $parser->parse_file("xml/spa_regdef.xml") or die;

my $module_name = "SPA_SFR";
my $sfr_fn      = "sfr/spa_sfr_t.v";

# backup
if (-e $sfr_fn) {
    rename($sfr_fn, "$sfr_fn.old");
}
open (my $fp, ">", $sfr_fn) || die "couldn't open '".$sfr_fn."' for writing because ".$!;

# apb signal
my $pclk   ="i_PCLK";
my $preset ="i_PRESETn";
my $paddr  ="i_PADDR";
my $psel   ="i_PSEL";
my $penable="i_PENABLE";
my $pwrite ="i_PWRITE";
my $pwdata ="i_PWDATA";
my $prdata ="o_PRDATA";
#my %pbus   = ( $pclk,    "1",
#               $preset,  "1",
#               $paddr,   "8",
#               $psel,    "1",
#               $penable, "1",
#               $pwrite,  "1",
#               $pwdata, "32",
#               $prdata, "32", );
my @pbus_n = ( $pclk, $preset, $paddr, $psel, $penable, $pwrite, $pwdata, $prdata, );
my @pbus_i = (  "in",    "in",   "in",  "in",     "in",    "in",    "in",   "out", );
my @pbus_w = (   "1",     "1",   "11",   "1",      "1",     "1",    "32",    "32", ); 
my @pbus_b;

print "##--------------------------------------------\n";
print "## rtl for sfr generation. \n";
print "## by sanggeul.lee\@hp.com. \n";
print "## ver. 20180731. \n";
print "##--------------------------------------------\n";
print "\n";

print "##--------------------------------------------\n";
print "## read xml information. \n";
print "##--------------------------------------------\n";
print '@register=$spx->getElementsByTagName("register")'."\n";
my @register=$spx->getElementsByTagName("register");
print ".\n\n";


print "##--------------------------------------------\n";
print "## set module input, output. \n";
print "##--------------------------------------------\n";
print $fp "\n";
print $fp "module $module_name\n";
print $fp "(\n";
print $fp "\t  "."// APB Interface"."\n"; # initial inout
print $fp "\t  ".$pbus_n[0]   ."\n";
foreach my $i (1 .. $#pbus_n) {
    print $fp "\t, ".$pbus_n[$i]   ."\n";
}
print $fp "\n";

# from xml
foreach my $t (@register) {
    my $r_name   = $t->getAttribute('name');
    my @filed = $t->getElementsByTagName("field");
    print $fp "\t  "."// $r_name "."\n";
    # filed for loop
    foreach my $tt (@filed) {
        my $f_name    = $tt->getAttribute('name');
        print $fp "\t, o_".$f_name  ."\n";
    }
    print $fp "\n";
}
print $fp ");\n\n";
print ".\n\n";

print "##--------------------------------------------\n";
print "## set parameter. \n";
print "##--------------------------------------------\n";
print $fp "// Parameters (Basic)\n";
#print $fp "parameters   \n";
#print $fp "parameters   \n";
#print $fp "parameters   \n";
#print $fp "parameters   \n";
print $fp "\n";

print $fp "// Parameters (SFR Addr)\n"; # initial inout
# from xml
foreach my $t (@register) {
    my $r_name   = $t->getAttribute('name');
    my $r_offset = $t->getAttribute('offset');
    $r_name =~ s/_REG//;
    $r_offset =~ s/0x//;
    printf $fp "parameter\t%s\t\t\= 13'h%04x>>2;\n", $r_name, hex($r_offset);
}
print $fp "\n\n";
print ".\n\n";

print "##--------------------------------------------\n";
print "## declare input, output, reg and wire. \n";
print "##--------------------------------------------\n";
#print "## input, output, reg and wire. \n";
print $fp "// APB Interface\n"; # initial inout
foreach my $i (0 .. $#pbus_n) {
    $pbus_b[$i] = $pbus_w[$i] - 1;
    # if don't used i_ or o_ naming rule, use @pbus_i <- inout defined
    if    ($pbus_n[$i] =~ m/^i_/) { print $fp "input  ", (($pbus_b[$i]==0)?("\t\t\t"):("[$pbus_b[$i]:0]\t")) ,$pbus_n[$i],"\;\n"; } # last line w/o ","
    elsif ($pbus_n[$i] =~ m/^o_/) { print $fp "output ", (($pbus_b[$i]==0)?("\t\t\t"):("[$pbus_b[$i]:0]\t")) ,$pbus_n[$i],"\;\n"; }
    else                          { die "please, keep naming rule: i_ or o_"; }
}
print $fp "\n";

# from xml
foreach my $t (@register) {
    my $r_name   = $t->getAttribute('name');
    my @filed = $t->getElementsByTagName("field");
    print $fp "// $r_name\n";
    # filed for loop
    foreach my $tt (@filed) {
        my $f_name    = $tt->getAttribute('name');
        my $f_width   = $tt->getAttribute('width');
        $f_width = $f_width - 1;
        print $fp "output ", (($f_width==0)?("\t\t\t"):("[$f_width:0]\t")) , "o_$f_name", "\;\n";
    }
    print $fp "\n";
}
print $fp "\n\n";

foreach my $t (@register) {
    my $r_name   = $t->getAttribute('name');
    my @filed = $t->getElementsByTagName("field");
    print $fp "// $r_name\n";
    # filed for loop
    foreach my $tt (@filed) {
        my $f_name    = $tt->getAttribute('name');
        my $f_width   = $tt->getAttribute('width');
        $f_width = $f_width - 1;
        print $fp "wire ", (($f_width==0)?("\t\t\t"):("[$f_width:0]\t")) , "o_$f_name", "\;\n";
    }
    print $fp "\n";
}
print $fp "\n\n";

foreach my $t (@register) {
    my $r_name   = $t->getAttribute('name');
    my @filed = $t->getElementsByTagName("field");
    print $fp "// $r_name\n";
    # filed for loop
    foreach my $tt (@filed) {
        my $f_name    = $tt->getAttribute('name');
        my $f_width   = $tt->getAttribute('width');
        $f_width = $f_width - 1;
        print $fp "reg ", (($f_width==0)?("\t\t\t"):("[$f_width:0]\t")) , "r_$f_name", "\;\n";
    }
    print $fp "\n";
}
print $fp "\n\n";
print ".\n\n";

print "##--------------------------------------------\n";
print "## r/w enable generation. \n";
print "##--------------------------------------------\n";
my $wen = "w_wr_en";
my $ren = "w_rd_en";
print $fp "\n";
# from xml
print $fp "wire\t$wen\;\n";
print $fp "wire\t$ren\;\n";
print $fp "\n";
print $fp "assign\t$wen \= $psel \& \( $penable\) \& $pwrite\;\n";
print $fp "assign\t$ren \= $psel \& \(\~$penable\)\;\n";
print $fp "\n";
foreach my $t (@register) {
    my $r_name   = $t->getAttribute('name');
    my $r_offset = $t->getAttribute('offset');
    $r_offset =~ s/0x//;
    printf $fp "wire\tw_addr%04x_wr = %s & (%s == %s\t\t\)\;\n", hex($r_offset), $wen, $paddr, $r_name;
    printf $fp "wire\tw_addr%04x_rd = %s & (%s == %s\t\t\)\;\n", hex($r_offset), $ren, $paddr, $r_name;
}
print $fp "\n\n";
print ".\n\n";

print "##--------------------------------------------\n";
print "## describe sfr f/f and logic & output assign \n";
print "##--------------------------------------------\n";
# logic by access
# from xml
foreach my $t (@register) {
    my $r_name   = $t->getAttribute('name');
    my $r_offset = $t->getAttribute('offset');
    my @filed = $t->getElementsByTagName("field");
    $r_offset =~ s/0x//;

    my @matched = grep  /access\=\"rw|wo|w1c\"/i, @filed;
    if (@matched > 0) {
        print $fp "// $r_name register.\n\n";
        print $fp "always \@(negedge $preset or posedge $pclk) begin\n";
        print $fp "\tif (\!$preset) begin\n";
        foreach my $tt (@filed) {
            my $f_name    = $tt->getAttribute('name');
            my $f_access  = $tt->getAttribute('access');
            my $f_lsb     = $tt->getAttribute('lsb');
            my $f_width   = $tt->getAttribute('width');
            my $f_default = $tt->getAttribute('default');

            $f_access  = lc $f_access;
            $f_default =~ s/0x//;

            my $f_msb = $f_lsb + $f_width - 1;
            my $f_bit = $f_width - 1;
            #&ff($pclk, $preset, $r_offset, $f_name, $f_access, $f_lsb, $f_width, $f_default);
            if ($f_access eq "ro") {
                print $fp "\t\t\/\/r_$f_name\[$f_bit\:0\]\t\<\= $f_width\`h$f_default\; \/\/ read-only\n";
            }
            else {
                print $fp "\t\tr_$f_name\[$f_bit\:0\]\t\<\= $f_width\`h$f_default\;\n";
            }
        }
        print $fp "\tend\n";
        printf $fp "\telse if (w_addr%04x_wr) begin\n", hex($r_offset);
        foreach my $tt (@filed) {
            my $f_name    = $tt->getAttribute('name');
            my $f_access  = $tt->getAttribute('access');
            my $f_lsb     = $tt->getAttribute('lsb');
            my $f_width   = $tt->getAttribute('width');
            my $f_default = $tt->getAttribute('default');
    
            $f_access  = lc $f_access;
            $f_default =~ s/0x//;
    
            my $f_msb = $f_lsb + $f_width - 1;
            my $f_bit = $f_width - 1;
            if ($f_access eq "ro") {
                print $fp "\t\t\/\/r_$f_name\[$f_bit\:0\]\t\<\= $pwdata\[$f_msb\:$f_lsb\]\; \/\/ read-only\n";
            }
            else {
                print $fp "\t\tr_$f_name\[$f_bit\:0\]\t\<\= $pwdata\[$f_msb\:$f_lsb\]\;\n";
            }
        }
        print $fp "\tend\n";
        print $fp "\telse begin\n";
        foreach my $tt (@filed) {
            my $f_name    = $tt->getAttribute('name');
            my $f_access  = $tt->getAttribute('access');
            my $f_lsb     = $tt->getAttribute('lsb');
            my $f_width   = $tt->getAttribute('width');
            my $f_default = $tt->getAttribute('default');
    
            $f_access  = lc $f_access;
            $f_default =~ s/0x//;
    
            my $f_msb = $f_lsb + $f_width - 1;
            my $f_bit = $f_width - 1;
            if ($f_access eq "ro") {
                print $fp "\t\t\/\/r_$f_name\[$f_bit\:0\]\t\<\= r_$f_name\[$f_bit\:0\]\; \/\/ read-only\n";
            }
            else {
                print $fp "\t\tr_$f_name\[$f_bit\:0\]\t\<\= r_$f_name\[$f_bit\:0\]\;\n";
            }
        }
        print $fp "\tend\n";
        print $fp "end\n\n";
    }
    else {
        print $fp "// $r_name register\n\n";
    }

    print $fp "// output assign for $r_name\n";
    foreach my $tt (@filed) {
        my $f_name    = $tt->getAttribute('name');
        my $f_access  = $tt->getAttribute('access');
        my $f_lsb     = $tt->getAttribute('lsb');
        my $f_width   = $tt->getAttribute('width');

        $f_access  = lc $f_access;

        my $f_msb = $f_lsb + $f_width - 1;
        my $f_bit = $f_width - 1;
        if ($f_access eq "ro") {
            print $fp "assign o_$f_name\[$f_bit\:0\]\t\= $f_width\'h0 \/\* add logic \*\/ \;\n";
        }
        else {
            print $fp "assign o_$f_name\[$f_bit\:0\]\t\= r_$f_name\[$f_bit\:0\]\;\n";
        }
    }
    print $fp "\n\n";
}
print $fp "\n\n";

print ".\n\n";

print "##--------------------------------------------\n";
print "## prdata generation. \n";
print "##--------------------------------------------\n";
my $prdata_reg = "r_prdata";
print $fp "// Read prdata (sfr).\n";
print $fp "reg \[$pbus_b[$#pbus_n]:0\]\t", "$prdata_reg\;\n";
print $fp "wire [31:0]\tzeros\;\n";
print $fp "assign zeros\[31\:0\]\t\= 32\'h0\;\n";
print $fp "\n\n";
print $fp "always \@\(\*\) begin\n";
print $fp "\tcase \(1\'b1\)\n";
foreach my $t (@register) {
    my $r_name   = $t->getAttribute('name');
    my $r_offset = $t->getAttribute('offset');
    my @filed = $t->getElementsByTagName("field");
    
    printf $fp "\t\tw_addr%04x_rd\t\: $prdata_reg \= \{ ", hex($r_offset);
    my @prdata;
    my $idx=0;
    foreach my $tt (@filed) {
        my $f_name    = $tt->getAttribute('name');
        my $f_width   = $tt->getAttribute('width');
        my $f_lsb     = $tt->getAttribute('lsb');
        my $f_access  = $tt->getAttribute('access');
        my $f_bit = $f_width - 1;
        $f_access = lc $f_access;
        #print $fp "r_$f_name\[$f_bit\:0\] ";
        $prdata[$idx] = "$f_name\/$f_width\/$f_lsb\/$f_access";
        $idx++;
    }
    foreach my $i (reverse 0 .. $#prdata) {
        my @a; # upper side
        my @b; # lower side
        #print $fp "$prdata[$i], ";
        # wo process
        if ( ($i == $#prdata) && ($i == 0) ) { # if ($#prdata == 0)
            @a = split "/", $prdata[$i];

            if ( ($a[1]+$a[2]) < 32) {
                print $fp 32-($a[1]+$a[2]), "\'h0, "; 
            }

            if ( ($a[2]) > 0 ) {
                #if (($a[3] eq "wo")||($a[3] eq "w1c")) {
                if ($a[3] eq "wo") {
                    print $fp "\/\*", "r_", $a[0], "\[", $a[1]-1,"\:0\], ", "\*\/", $a[1], "\'h0, "; 
                    print $fp $a[2], "\'h0 "; 
                }
                else {
                    print $fp "r_", $a[0], "\[", $a[1]-1,"\:0\], "; 
                    print $fp $a[2], "\'h0 "; 
                }
            }
            else {
                #if (($a[3] eq "wo")||($a[3] eq "w1c")) {
                if ($a[3] eq "wo") {
                    print $fp "\/\*", "r_", $a[0], "\[", $a[1]-1,"\:0\] ", "\*\/", $a[1], "\'h0 "; 
                }
                else {
                    print $fp "r_", $a[0], "\[", $a[1]-1,"\:0\] "; 
                }
            }
        }
        elsif ($i == $#prdata) {
            @a = split "/", $prdata[$i];
            @b = split "/", $prdata[$i-1];

            if ( ($a[1]+$a[2]) < 32) {
                print $fp 32-($a[1]+$a[2]), "\'h0, "; 
            }

            # if (($a[3] eq "wo")||($a[3] eq "w1c")) {
            if ($a[3] eq "wo") {
                print $fp "\/\*", "r_", $a[0], "\[", $a[1]-1,"\:0\], ", "\*\/", $a[1], "\'h0, "; 
            }
            else {
                print $fp "r_", $a[0], "\[", $a[1]-1,"\:0\], "; 
            }

            if ($a[2] > ($b[1]+$b[2])) {
                print $fp ($a[2]-$b[2]-$b[1]), "\'h0, "; 
            }
        }
        elsif ($i == 0) {
            @a = split "/", $prdata[$i];

            if ( ($a[2]) > 0 ) {
                #if (($a[3] eq "wo")||($a[3] eq "w1c")) {
                if ($a[3] eq "wo") {
                    print $fp "\/\*", "r_", $a[0], "\[", $a[1]-1,"\:0\], ", "\*\/", $a[1], "\'h0, "; 
                    print $fp $a[2], "\'h0 "; 
                }
                else {
                    print $fp "r_", $a[0], "\[", $a[1]-1,"\:0\], "; 
                    print $fp $a[2], "\'h0 "; 
                }
            }
            else {
                #if (($a[3] eq "wo")||($a[3] eq "w1c")) {
                if ($a[3] eq "wo") {
                    print $fp "\/\*", "r_", $a[0], "\[", $a[1]-1,"\:0\] ", "\*\/", $a[1], "\'h0 "; 
                }
                else {
                    print $fp "r_", $a[0], "\[", $a[1]-1,"\:0\] "; 
                }
            }
        }
        else {
            @a = split "/", $prdata[$i];
            @b = split "/", $prdata[$i-1];

            # if (($a[3] eq "wo")||($a[3] eq "w1c")) {
            if ($a[3] eq "wo") {
                print $fp "\/\*", "r_", $a[0], "\[", $a[1]-1,"\:0\], ", "\*\/", $a[1], "\'h0, "; 
            }
            else {
                print $fp "r_", $a[0], "\[", $a[1]-1,"\:0\], "; 
            }

            if ($a[2] > ($b[1]+$b[2])) {
                print $fp ($a[2]-$b[2]-$b[1]), "\'h0, "; 
            }

            # line arange
            if (($i%4) == 0) {
                print $fp "\n\t\t\t\t\t\t\t\t\t";
            }
        }
    }
    #join
    print $fp "\}\;\n";
}
print $fp "\t\tdefault\t\t\: $prdata_reg\t\= 32\'h0\;\n";
print $fp "\tendcase\n";
print $fp "end\n\n";

print $fp "assign $prdata\t\= $prdata_reg\;\n";
print $fp "\n\n";

print ".\n\n";

print "##--------------------------------------------\n";
print "## last process. \n";
print "##--------------------------------------------\n";
print $fp "\n";
print $fp "endmodule\n";

close ($fp);

print ".\n\n";

#&ff($pclk, $preset, $r_offset, $f_name, $f_access, $f_lsb, $f_width, $f_default);
sub ff {
    my $clk     = shift;
    my $reset   = shift;
    my $offset  = shift;
    my $name    = shift;
    my $access  = shift;
    my $lsb     = shift;
    my $width   = shift;
    my $default = shift;

    if ($access eq "rw") {
    }
    elsif ($access eq "ro") {
    }
    elsif ($access eq "wo") {
    }
    elsif ($access eq "w1c") {
    }
    else {
        die "Error, this type is not included in anywhere.\n";
    }

    #switch ($f_access) {
    #    case "rw"  { print "case rw\n"; }
    #    case "ro"  { print "case ro\n"; }
    #    case "wo"  { print "case wo\n"; }
    #    case "w1c" { print "case w1c\n"; }
    #    else       { print "case else\n"; }
    #}


}



## reference, from xml
#foreach my $t (@register) {
#    my $r_name   = $t->getAttribute('name');
#    my $r_offset = $t->getAttribute('offset');
#    my @filed = $t->getElementsByTagName("field");
#    # filed for loop
#    foreach my $tt (@filed) {
#        my $f_name    = $tt->getAttribute('name');
#        my $f_access  = $tt->getAttribute('access');
#        my $f_lsb     = $tt->getAttribute('lsb');
#        my $f_width   = $tt->getAttribute('width');
#        my $f_default = $tt->getAttribute('default');
#    }
#}

