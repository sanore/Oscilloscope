// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
// Date        : Mon Nov 28 14:48:57 2022
// Host        : WS-EL-501017 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               u:/DigMe/Oscilloscope/project/Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ip/oscilloscope_bd_osci_0_1/oscilloscope_bd_osci_0_1_sim_netlist.v
// Design      : oscilloscope_bd_osci_0_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "oscilloscope_bd_osci_0_1,osci,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "osci,Vivado 2021.1" *) 
(* NotValidForBitStream *)
module oscilloscope_bd_osci_0_1
   (clk,
    rst,
    ch1_adc,
    ch1_irq,
    ch1_en,
    ch1_rst,
    ch1_mode,
    ch1_edge_sel,
    ch1_edge_thre,
    ch1_ram_data,
    ch1_ram_adr);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input clk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 rst RST" *) (* x_interface_parameter = "XIL_INTERFACENAME rst, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input rst;
  input [11:0]ch1_adc;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 ch1_irq INTERRUPT" *) (* x_interface_parameter = "XIL_INTERFACENAME ch1_irq, SENSITIVITY LEVEL_HIGH, PortWidth 1" *) output ch1_irq;
  input ch1_en;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 ch1_rst RST" *) (* x_interface_parameter = "XIL_INTERFACENAME ch1_rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input ch1_rst;
  input [3:0]ch1_mode;
  input [3:0]ch1_edge_sel;
  input [15:0]ch1_edge_thre;
  output [15:0]ch1_ram_data;
  input [12:0]ch1_ram_adr;

  wire \<const0> ;
  wire [12:0]ch1_ram_adr;
  wire [15:0]ch1_ram_data;
  wire ch1_rst;
  wire clk;
  wire rst;

  assign ch1_irq = \<const0> ;
  GND GND
       (.G(\<const0> ));
  oscilloscope_bd_osci_0_1_osci U0
       (.ch1_ram_adr(ch1_ram_adr),
        .ch1_ram_data(ch1_ram_data),
        .ch1_rst(ch1_rst),
        .clk(clk),
        .rst(rst));
endmodule

(* ORIG_REF_NAME = "channel" *) 
module oscilloscope_bd_osci_0_1_channel
   (ch1_ram_data,
    clk,
    Q,
    read_en,
    rst,
    ch1_rst);
  output [15:0]ch1_ram_data;
  input clk;
  input [12:0]Q;
  input read_en;
  input rst;
  input ch1_rst;

  wire [12:0]Q;
  wire [15:0]ch1_ram_data;
  wire ch1_rst;
  wire clk;
  wire read_en;
  wire rst;
  wire storage_i_1_n_0;

  (* ADDR_WIDTH = "13" *) 
  (* DATA_WIDTH = "16" *) 
  oscilloscope_bd_osci_0_1_ram storage
       (.clk(clk),
        .read_address(Q),
        .read_data(ch1_ram_data),
        .read_en(read_en),
        .rst(storage_i_1_n_0),
        .write_address({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .write_data({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .write_en(1'b0));
  LUT2 #(
    .INIT(4'hE)) 
    storage_i_1
       (.I0(rst),
        .I1(ch1_rst),
        .O(storage_i_1_n_0));
endmodule

(* ORIG_REF_NAME = "osci" *) 
module oscilloscope_bd_osci_0_1_osci
   (ch1_ram_data,
    ch1_ram_adr,
    clk,
    rst,
    ch1_rst);
  output [15:0]ch1_ram_data;
  input [12:0]ch1_ram_adr;
  input clk;
  input rst;
  input ch1_rst;

  wire [12:0]ch1_ram_adr;
  wire [15:0]ch1_ram_data;
  wire ch1_rst;
  wire clk;
  wire \last_read_address[12]_i_3_n_0 ;
  wire \last_read_address[12]_i_4_n_0 ;
  wire \last_read_address[12]_i_5_n_0 ;
  wire \last_read_address[12]_i_6_n_0 ;
  wire \last_read_address[12]_i_7_n_0 ;
  wire \last_read_address_reg[12]_i_2_n_0 ;
  wire \last_read_address_reg[12]_i_2_n_1 ;
  wire \last_read_address_reg[12]_i_2_n_2 ;
  wire \last_read_address_reg[12]_i_2_n_3 ;
  wire p_0_in;
  wire [12:0]read_address;
  wire read_en;
  wire rst;
  wire [3:1]\NLW_last_read_address_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_last_read_address_reg[12]_i_1_O_UNCONNECTED ;
  wire [3:0]\NLW_last_read_address_reg[12]_i_2_O_UNCONNECTED ;

  oscilloscope_bd_osci_0_1_channel ch1
       (.Q(read_address),
        .ch1_ram_data(ch1_ram_data),
        .ch1_rst(ch1_rst),
        .clk(clk),
        .read_en(read_en),
        .rst(rst));
  FDRE ch1_read_en_reg
       (.C(clk),
        .CE(1'b1),
        .D(p_0_in),
        .Q(read_en),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h9)) 
    \last_read_address[12]_i_3 
       (.I0(ch1_ram_adr[12]),
        .I1(read_address[12]),
        .O(\last_read_address[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \last_read_address[12]_i_4 
       (.I0(read_address[9]),
        .I1(ch1_ram_adr[9]),
        .I2(ch1_ram_adr[11]),
        .I3(read_address[11]),
        .I4(ch1_ram_adr[10]),
        .I5(read_address[10]),
        .O(\last_read_address[12]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \last_read_address[12]_i_5 
       (.I0(read_address[6]),
        .I1(ch1_ram_adr[6]),
        .I2(ch1_ram_adr[8]),
        .I3(read_address[8]),
        .I4(ch1_ram_adr[7]),
        .I5(read_address[7]),
        .O(\last_read_address[12]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \last_read_address[12]_i_6 
       (.I0(read_address[3]),
        .I1(ch1_ram_adr[3]),
        .I2(ch1_ram_adr[5]),
        .I3(read_address[5]),
        .I4(ch1_ram_adr[4]),
        .I5(read_address[4]),
        .O(\last_read_address[12]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \last_read_address[12]_i_7 
       (.I0(read_address[0]),
        .I1(ch1_ram_adr[0]),
        .I2(ch1_ram_adr[2]),
        .I3(read_address[2]),
        .I4(ch1_ram_adr[1]),
        .I5(read_address[1]),
        .O(\last_read_address[12]_i_7_n_0 ));
  FDRE \last_read_address_reg[0] 
       (.C(clk),
        .CE(p_0_in),
        .D(ch1_ram_adr[0]),
        .Q(read_address[0]),
        .R(1'b0));
  FDRE \last_read_address_reg[10] 
       (.C(clk),
        .CE(p_0_in),
        .D(ch1_ram_adr[10]),
        .Q(read_address[10]),
        .R(1'b0));
  FDRE \last_read_address_reg[11] 
       (.C(clk),
        .CE(p_0_in),
        .D(ch1_ram_adr[11]),
        .Q(read_address[11]),
        .R(1'b0));
  FDRE \last_read_address_reg[12] 
       (.C(clk),
        .CE(p_0_in),
        .D(ch1_ram_adr[12]),
        .Q(read_address[12]),
        .R(1'b0));
  CARRY4 \last_read_address_reg[12]_i_1 
       (.CI(\last_read_address_reg[12]_i_2_n_0 ),
        .CO({\NLW_last_read_address_reg[12]_i_1_CO_UNCONNECTED [3:1],p_0_in}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O(\NLW_last_read_address_reg[12]_i_1_O_UNCONNECTED [3:0]),
        .S({1'b0,1'b0,1'b0,\last_read_address[12]_i_3_n_0 }));
  CARRY4 \last_read_address_reg[12]_i_2 
       (.CI(1'b0),
        .CO({\last_read_address_reg[12]_i_2_n_0 ,\last_read_address_reg[12]_i_2_n_1 ,\last_read_address_reg[12]_i_2_n_2 ,\last_read_address_reg[12]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b1,1'b1,1'b1,1'b1}),
        .O(\NLW_last_read_address_reg[12]_i_2_O_UNCONNECTED [3:0]),
        .S({\last_read_address[12]_i_4_n_0 ,\last_read_address[12]_i_5_n_0 ,\last_read_address[12]_i_6_n_0 ,\last_read_address[12]_i_7_n_0 }));
  FDRE \last_read_address_reg[1] 
       (.C(clk),
        .CE(p_0_in),
        .D(ch1_ram_adr[1]),
        .Q(read_address[1]),
        .R(1'b0));
  FDRE \last_read_address_reg[2] 
       (.C(clk),
        .CE(p_0_in),
        .D(ch1_ram_adr[2]),
        .Q(read_address[2]),
        .R(1'b0));
  FDRE \last_read_address_reg[3] 
       (.C(clk),
        .CE(p_0_in),
        .D(ch1_ram_adr[3]),
        .Q(read_address[3]),
        .R(1'b0));
  FDRE \last_read_address_reg[4] 
       (.C(clk),
        .CE(p_0_in),
        .D(ch1_ram_adr[4]),
        .Q(read_address[4]),
        .R(1'b0));
  FDRE \last_read_address_reg[5] 
       (.C(clk),
        .CE(p_0_in),
        .D(ch1_ram_adr[5]),
        .Q(read_address[5]),
        .R(1'b0));
  FDRE \last_read_address_reg[6] 
       (.C(clk),
        .CE(p_0_in),
        .D(ch1_ram_adr[6]),
        .Q(read_address[6]),
        .R(1'b0));
  FDRE \last_read_address_reg[7] 
       (.C(clk),
        .CE(p_0_in),
        .D(ch1_ram_adr[7]),
        .Q(read_address[7]),
        .R(1'b0));
  FDRE \last_read_address_reg[8] 
       (.C(clk),
        .CE(p_0_in),
        .D(ch1_ram_adr[8]),
        .Q(read_address[8]),
        .R(1'b0));
  FDRE \last_read_address_reg[9] 
       (.C(clk),
        .CE(p_0_in),
        .D(ch1_ram_adr[9]),
        .Q(read_address[9]),
        .R(1'b0));
endmodule

(* ADDR_WIDTH = "13" *) (* DATA_WIDTH = "16" *) (* ORIG_REF_NAME = "ram" *) 
module oscilloscope_bd_osci_0_1_ram
   (clk,
    rst,
    write_address,
    write_data,
    write_en,
    read_address,
    read_data,
    read_en);
  input clk;
  input rst;
  input [12:0]write_address;
  input [15:0]write_data;
  input write_en;
  input [12:0]read_address;
  output [15:0]read_data;
  input read_en;


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
