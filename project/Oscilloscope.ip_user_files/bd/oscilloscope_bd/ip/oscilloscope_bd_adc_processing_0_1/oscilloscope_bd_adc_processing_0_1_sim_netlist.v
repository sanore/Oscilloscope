// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
// Date        : Wed Nov 30 11:41:36 2022
// Host        : hn600365 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top oscilloscope_bd_adc_processing_0_1 -prefix
//               oscilloscope_bd_adc_processing_0_1_ oscilloscope_bd_adc_processing_0_0_sim_netlist.v
// Design      : oscilloscope_bd_adc_processing_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module oscilloscope_bd_adc_processing_0_1_adc_processing
   (ch1_adc,
    adc_data,
    adc_valid);
  output [11:0]ch1_adc;
  input [11:0]adc_data;
  input adc_valid;

  wire [11:0]adc_data;
  wire adc_valid;
  wire [11:0]ch1_adc;

  FDRE \ch1_data_reg_reg[0] 
       (.C(adc_valid),
        .CE(1'b1),
        .D(adc_data[0]),
        .Q(ch1_adc[0]),
        .R(1'b0));
  FDRE \ch1_data_reg_reg[10] 
       (.C(adc_valid),
        .CE(1'b1),
        .D(adc_data[10]),
        .Q(ch1_adc[10]),
        .R(1'b0));
  FDRE \ch1_data_reg_reg[11] 
       (.C(adc_valid),
        .CE(1'b1),
        .D(adc_data[11]),
        .Q(ch1_adc[11]),
        .R(1'b0));
  FDRE \ch1_data_reg_reg[1] 
       (.C(adc_valid),
        .CE(1'b1),
        .D(adc_data[1]),
        .Q(ch1_adc[1]),
        .R(1'b0));
  FDRE \ch1_data_reg_reg[2] 
       (.C(adc_valid),
        .CE(1'b1),
        .D(adc_data[2]),
        .Q(ch1_adc[2]),
        .R(1'b0));
  FDRE \ch1_data_reg_reg[3] 
       (.C(adc_valid),
        .CE(1'b1),
        .D(adc_data[3]),
        .Q(ch1_adc[3]),
        .R(1'b0));
  FDRE \ch1_data_reg_reg[4] 
       (.C(adc_valid),
        .CE(1'b1),
        .D(adc_data[4]),
        .Q(ch1_adc[4]),
        .R(1'b0));
  FDRE \ch1_data_reg_reg[5] 
       (.C(adc_valid),
        .CE(1'b1),
        .D(adc_data[5]),
        .Q(ch1_adc[5]),
        .R(1'b0));
  FDRE \ch1_data_reg_reg[6] 
       (.C(adc_valid),
        .CE(1'b1),
        .D(adc_data[6]),
        .Q(ch1_adc[6]),
        .R(1'b0));
  FDRE \ch1_data_reg_reg[7] 
       (.C(adc_valid),
        .CE(1'b1),
        .D(adc_data[7]),
        .Q(ch1_adc[7]),
        .R(1'b0));
  FDRE \ch1_data_reg_reg[8] 
       (.C(adc_valid),
        .CE(1'b1),
        .D(adc_data[8]),
        .Q(ch1_adc[8]),
        .R(1'b0));
  FDRE \ch1_data_reg_reg[9] 
       (.C(adc_valid),
        .CE(1'b1),
        .D(adc_data[9]),
        .Q(ch1_adc[9]),
        .R(1'b0));
endmodule

(* CHECK_LICENSE_TYPE = "oscilloscope_bd_adc_processing_0_0,adc_processing,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "adc_processing,Vivado 2021.1" *) 
(* NotValidForBitStream *)
module oscilloscope_bd_adc_processing_0_1
   (adc_data,
    adc_valid,
    ch1_adc);
  input [15:0]adc_data;
  input adc_valid;
  output [11:0]ch1_adc;

  wire [15:0]adc_data;
  wire adc_valid;
  wire [11:0]ch1_adc;

  oscilloscope_bd_adc_processing_0_1_adc_processing U0
       (.adc_data(adc_data[11:0]),
        .adc_valid(adc_valid),
        .ch1_adc(ch1_adc));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
