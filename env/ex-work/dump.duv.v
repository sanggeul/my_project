//==================================================================================================
// Created by    : Telechips
// Filename      : dump.v
// Author        : sukhyun
// Created On    : 2014-04-01 16:08
// Last Modified : 2015-09-11 14:18 by sglee86
//
// Svn Info:
//   $Revision::                                                                                $:
//   $Author::                                                                                  $:
//   $Date::                                                                                    $:
//   $HeadURL::                                                                                 $:
//
// Description:
//
//
//==================================================================================================
`timescale 1ns / 1ps

module dump(/*AUTOARG*/);

/*AUTOINPUT*/
/*AUTOOUTPUT*/
/*AUTOINOUT*/

/*AUTOWIRE*/
/*AUTOREG*/

initial begin

`ifdef DUMP_FILE
    $fsdbDumpfile(`DUMP_FILE);
`else
    $fsdbDumpfile("./dump/dump.fsdb");
`endif

$fsdbDumpvars(0,TEST_TOP);
$fsdbDumpvars(0,TEST_TOP.xCMBUS);
$fsdbDumpvars(0,TEST_TOP.x_otprom_wrap);
$fsdbDumpvars(0,TEST_TOP.x_pmu_coreif);
$fsdbDumpvars(0,TEST_TOP.x_fileio_m4);

end

endmodule

/*
Local Variables:
verilog-library-extensions:(".v" ".vp")
verilog-library-directories:("./")
verilog-auto-inst-arg-case:"downcase"
indent-tabs-mode:nil
verilog-auto-inst-param-value:t
verilog-auto-inst-sort:nil
verilog-auto-inst-template-numbers:t
tab-width:4
vim:ts=4:et:sw=4:sts=4
End:
*/

