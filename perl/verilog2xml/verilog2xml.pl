#!/usr/bin/env perl

use XML::DOM;

use Verification::CmdLine;
use PHYS::PARSE::DesignSourceParser;
my $g_ut               = new Verification::Component("verilog2xml.pl");
my $g_cmdLine          = "buildMaster.pl @ARGV";
my $g_optDebug = 0;
my $g_optHelp = 0;
my $g_optVopt = "";

use File::Basename;
use Cwd 'abs_path';

use Verilog::Netlist;
use Verilog::Getopt;

#------------------------------------------------------------------
# Command line interface: Declare, document, and bind arguments in one place
#------------------------------------------------------------------

my $opt = new Verification::CmdLine("verilog2xml.pl", "1.0");

$opt->addDescription("Read verilog file and generate basic xml to be used with buildMaster.pl");
$opt->addSwitchedArg("file=s", "<filename>",         \$g_optFileName,  "File to be parsed");
$opt->addSwitchedArg("ds=s", "<design_source>",      \$g_optdsFile,  "File to be parsed");
$opt->addSwitchedArg("top=s", "<top module>",  \$g_optTop,      "Use this as toplevel");
$opt->addSwitchedArg("vopt=s", "<verilog options>",  \$g_optVopt,      "Verilog options");
$opt->addSwitchedArg("noports",    "",       \$g_optNoPorts,   "Skip printing of ports element (ideal for internal blocks)");
$opt->addSwitchedArg("stub",    "",       \$g_optMakeStub,   "Tie off outputs to create a stub file for gate sims)");
$opt->addSwitchedArg("help|h|?!",  "",       \$g_optHelp,      "Prints usage information");
$opt->addSwitchedArg("debug=i",  "<level>",  \$g_optDebug,     "Specify debug level (0-N, default=0)");

my @moduleFiles = ();
my @incPaths = ();
my $g_usage = $opt->getUsage();

$opt->parseArgs();

if ($g_optHelp) {
   die("$g_usage\nHelp option invoked\n");
}

if (defined $g_optFileName) {
  push (@moduleFiles,$g_optFileName);
} elsif (defined $g_optdsFile) {
  my $rootDesignSourceTree = new PHYS::PARSE::DesignSourceParser($g_optdsFile);
  $ds = $rootDesignSourceTree->getRootDesignSource();
  @moduleFiles = $ds->getAllSourceFiles();
  @incPaths = $ds->getAllIncPaths();
}

my $printPorts;
if (defined $g_optNoPorts) {
  $printPorts = 0;
} else {
  $printPorts = 1;
}

my $makeStub;
my $outFile;


my $vopt = new Verilog::Getopt;
my @preProcParamStrings;
foreach my $incPath (@incPaths) {
   my $incPath = "+incdir+$incPath";
   push (@preProcParamStrings, $incPath);
}

my @gvopt = split " ",$g_optVopt;
push (@preProcParamStrings, @gvopt);
$vopt->parameter(@preProcParamStrings);

if ($g_optDebug > 0) {
   foreach my $iDir ($vopt->incdir()) {
      print "include dir $iDir \n";
   }
}

open LOG,'>',"verilog2xml.log";

local $SIG{__WARN__} = sub {
    $msg = shift;
    print LOG "$msg";
   };

my $nl;
   $nl = new Verilog::Netlist(options=>$vopt,
                              link_read_nonfatal => 1,
                              synthesis => 0,
                              );

foreach my $mfile (@moduleFiles) {
  if ($mfile =~ /.*v$|.*vp$/) 
  {
    print " Reading $mfile\n";
    $nl->read_file(filename=>$mfile);
  } else {
    print " Ignoring file $mfile\n";
  }
}
  $nl->link();
  my @allMods = $nl->modules_sorted_level();

  my $topName;
  my $topModule;
  if (defined $g_optTop) {
     $topName = $g_optTop;
     $topModule =$nl->find_module($topName);
  } else {
  # top level is last in list
    $topModule = pop(@allMods);
    $topName = $topModule->name();
  }
  print (" Top Module is $topName\n");
  
if (defined $g_optMakeStub) {
   $makeStub = 1;
   $outFile = $topName . "_stub" . ".xml";
} else {
   $makeStub = 0;
   $outFile = $topName . ".xml";
}

  open(XML, ">", $outFile);
  my $iName = "I_" . $topName;
  if ($makeStub) {
    printf XML "<design designName=\"%s\" hdl=\"verilog\" xref=\"\" >\n",$topName;
    print  XML "   <view name=\"gate_stub\">\n";
  } else {
    printf XML "<design designName=\"%s\">\n",$topName;
    print  XML "   <view name=\"rtl\">\n";
    if (defined $g_optdsFile) {
      printf XML "      <instance name=\"%s\" iname=\"%s\"\n",$topName, $iName;
      printf XML "                xref=\"%s\">\n",$g_ut->getNiceFileName($g_optdsFile);
    } else {
      printf XML "      <instance name=\"%s\" iname=\"%s\" >\n",$topName, $iName;
      printf XML "         <parameter name=\"%s\" value=\"%s\" />\n","my_parameter", "my_parameter_value";
    }
    print  XML "      </instance>\n";
  }

  if ($makeStub) {
   printf XML ("   <insertCode>\n");
   foreach my $port ($topModule->ports_ordered()) {
     my $pName = $port->name();
     my $pDir = $port->direction();
     if ($pDir eq "out") {
       my $net = $port->net();
       my $width = $net->width();
       # $width is not set when it is actually 1
       $width = ($width >1) ? $width : 1;
       if ($g_optDebug) {
         print ("tie off output port: $pName $pDir $width \n");
       }
       if ($pName =~ /ft_(.*)_out/) {
         if ($g_optDebug) {
            print ("found feedthru port: $pName \n");
         }
         printf XML "   assign   %s = ft_$1_in;\n",$pName;
       } else {
         printf XML "   assign   %s = %s\'b0;\n",$pName,$width;
       }
     }
   }
   printf XML "   </insertCode>\n";
   }

  print  XML "   </view>\n";

  if ($printPorts) {
  print  XML "   <ports>\n";
  foreach my $port ($topModule->ports_ordered()) {
     my $pName = $port->name();
     my $pDir = $port->direction();
     if (($pDir ne "interface")||($pDir ne "inout")) {
        $pDir = $pDir . put;
     }
     # type should give port size
     my $pSize = $port->data_type();
     # strip reg/wire out of the type - we're only interested in size here! 
     $pSize =~ s/reg\b |wire\b |logic\b |signed\b //g;
     my $net = $port->net();
     my $width = $net->width();
     my $lsb = $net->lsb();
     my $msb = $net->msb();
     my $array = $port->array();
     if ($g_optDebug) {
        print ("found Port: $pName $pDir $pSize $width $msb $lsb $array\n");
     }
     printf XML "      <port pName=\"%s\" dir=\"%s\"",$pName,$pDir;
     if ($width > 1) {
       printf XML " size=\"%s\"",$pSize;
     }
     if ($array =~ /\[.*\]/g) {
       printf XML " array=\"%s\"",$array;
     }
     printf XML "/>\n";
       
  }
  print  XML "   </ports>\n";
}
  if (!$makeStub) {
   print  XML "   <connections iname=\"$iName\">\n";
   foreach my $port ($topModule->ports_ordered()) {
     my $pName = $port->name();
     printf XML "      <connect pName=\"%s\" sigName=\"%s\"/>\n",$pName,$pName;
   }

   print  XML "   </connections>\n";
  }
  print  XML "</design>\n";

if ($g_optDebug > 2) {
   $topModule->dump();
}
