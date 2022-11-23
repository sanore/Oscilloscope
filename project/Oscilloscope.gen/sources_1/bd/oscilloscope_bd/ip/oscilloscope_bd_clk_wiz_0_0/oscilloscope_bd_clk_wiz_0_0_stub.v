// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
// Date        : Wed Nov 23 16:53:59 2022
// Host        : WS-EL-501017 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               u:/DigMe/Oscilloscope/project/Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ip/oscilloscope_bd_clk_wiz_0_0/oscilloscope_bd_clk_wiz_0_0_stub.v
// Design      : oscilloscope_bd_clk_wiz_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module oscilloscope_bd_clk_wiz_0_0(clk_out1, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,reset,locked,clk_in1" */;
  output clk_out1;
  input reset;
  output locked;
  input clk_in1;
endmodule
