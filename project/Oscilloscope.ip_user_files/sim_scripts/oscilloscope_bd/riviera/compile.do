vlib work
vlib riviera

vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/xil_defaultlib
vlib riviera/xlconstant_v1_1_7
vlib riviera/lib_cdc_v1_0_2
vlib riviera/proc_sys_reset_v5_0_13
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_vip_v1_1_10
vlib riviera/processing_system7_vip_v1_0_12

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib
vmap xlconstant_v1_1_7 riviera/xlconstant_v1_1_7
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_13 riviera/proc_sys_reset_v5_0_13
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_10 riviera/axi_vip_v1_1_10
vmap processing_system7_vip_v1_0_12 riviera/processing_system7_vip_v1_0_12

vlog -work xilinx_vip  -sv2k12 "+incdir+D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/include" \
"D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -sv2k12 "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/6dcf" "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/ec67/hdl" "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/f42d/hdl" "+incdir+D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/include" \
"D:/Software/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"D:/Software/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/oscilloscope_bd/ip/oscilloscope_bd_xadc_wiz_0_0/oscilloscope_bd_xadc_wiz_0_0_drp_to_axi_stream.vhd" \
"../../../bd/oscilloscope_bd/ip/oscilloscope_bd_xadc_wiz_0_0/oscilloscope_bd_xadc_wiz_0_0_xadc_core_drp.vhd" \
"../../../bd/oscilloscope_bd/ip/oscilloscope_bd_xadc_wiz_0_0/oscilloscope_bd_xadc_wiz_0_0_axi_xadc.vhd" \
"../../../bd/oscilloscope_bd/ip/oscilloscope_bd_xadc_wiz_0_0/oscilloscope_bd_xadc_wiz_0_0.vhd" \

vlog -work xlconstant_v1_1_7  -v2k5 "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/6dcf" "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/ec67/hdl" "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/f42d/hdl" "+incdir+D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/include" \
"../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/fcfc/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/6dcf" "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/ec67/hdl" "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/f42d/hdl" "+incdir+D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/include" \
"../../../bd/oscilloscope_bd/ip/oscilloscope_bd_xlconstant_0_0/sim/oscilloscope_bd_xlconstant_0_0.v" \
"../../../bd/oscilloscope_bd/ip/oscilloscope_bd_clk_wiz_0_0/oscilloscope_bd_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/oscilloscope_bd/ip/oscilloscope_bd_clk_wiz_0_0/oscilloscope_bd_clk_wiz_0_0.v" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_13 -93 \
"../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/oscilloscope_bd/ip/oscilloscope_bd_proc_sys_reset_0_0/sim/oscilloscope_bd_proc_sys_reset_0_0.vhd" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/6dcf" "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/ec67/hdl" "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/f42d/hdl" "+incdir+D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/include" \
"../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_10  -sv2k12 "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/6dcf" "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/ec67/hdl" "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/f42d/hdl" "+incdir+D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/include" \
"../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/0980/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_12  -sv2k12 "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/6dcf" "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/ec67/hdl" "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/f42d/hdl" "+incdir+D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/include" \
"../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/f42d/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/6dcf" "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/ec67/hdl" "+incdir+../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/f42d/hdl" "+incdir+D:/Software/Xilinx/Vivado/2021.1/data/xilinx_vip/include" \
"../../../bd/oscilloscope_bd/ip/oscilloscope_bd_processing_system7_0_1/sim/oscilloscope_bd_processing_system7_0_1.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/oscilloscope_bd/ip/oscilloscope_bd_adc_processing_0_0/sim/oscilloscope_bd_adc_processing_0_0.vhd" \
"../../../bd/oscilloscope_bd/ip/oscilloscope_bd_osci_0_1/sim/oscilloscope_bd_osci_0_1.vhd" \
"../../../bd/oscilloscope_bd/ipshared/85d3/hdl/OsciToCpu_v1_S00_AXI.vhd" \
"../../../bd/oscilloscope_bd/ipshared/85d3/hdl/OsciToCpu_v1.vhd" \
"../../../bd/oscilloscope_bd/ip/oscilloscope_bd_OsciToCpu_0_3/sim/oscilloscope_bd_OsciToCpu_0_3.vhd" \
"../../../bd/oscilloscope_bd/sim/oscilloscope_bd.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

