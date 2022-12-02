-makelib ies_lib/xilinx_vip -sv \
  "C:/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "C:/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "C:/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "C:/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "C:/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "C:/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "C:/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "C:/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "C:/Xilinx/Vivado/2021.1/data/xilinx_vip/hdl/rst_vip_if.sv" \
-endlib
-makelib ies_lib/xpm -sv \
  "C:/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "C:/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "C:/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/oscilloscope_bd/ip/oscilloscope_bd_xadc_wiz_0_0/oscilloscope_bd_xadc_wiz_0_0_drp_to_axi_stream.vhd" \
  "../../../bd/oscilloscope_bd/ip/oscilloscope_bd_xadc_wiz_0_0/oscilloscope_bd_xadc_wiz_0_0_xadc_core_drp.vhd" \
  "../../../bd/oscilloscope_bd/ip/oscilloscope_bd_xadc_wiz_0_0/oscilloscope_bd_xadc_wiz_0_0_axi_xadc.vhd" \
  "../../../bd/oscilloscope_bd/ip/oscilloscope_bd_xadc_wiz_0_0/oscilloscope_bd_xadc_wiz_0_0.vhd" \
-endlib
-makelib ies_lib/xlconstant_v1_1_7 \
  "../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/fcfc/hdl/xlconstant_v1_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/oscilloscope_bd/ip/oscilloscope_bd_xlconstant_0_0/sim/oscilloscope_bd_xlconstant_0_0.v" \
  "../../../bd/oscilloscope_bd/ip/oscilloscope_bd_clk_wiz_0_0/oscilloscope_bd_clk_wiz_0_0_clk_wiz.v" \
  "../../../bd/oscilloscope_bd/ip/oscilloscope_bd_clk_wiz_0_0/oscilloscope_bd_clk_wiz_0_0.v" \
-endlib
-makelib ies_lib/lib_cdc_v1_0_2 \
  "../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/proc_sys_reset_v5_0_13 \
  "../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/oscilloscope_bd/ip/oscilloscope_bd_proc_sys_reset_0_0/sim/oscilloscope_bd_proc_sys_reset_0_0.vhd" \
-endlib
-makelib ies_lib/axi_infrastructure_v1_1_0 \
  "../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_vip_v1_1_10 -sv \
  "../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/0980/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib ies_lib/processing_system7_vip_v1_0_12 -sv \
  "../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/f42d/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/oscilloscope_bd/ip/oscilloscope_bd_processing_system7_0_2/sim/oscilloscope_bd_processing_system7_0_2.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/oscilloscope_bd/ip/oscilloscope_bd_ila_1_0/sim/oscilloscope_bd_ila_1_0.vhd" \
  "../../../bd/oscilloscope_bd/ip/oscilloscope_bd_ila_0_0/sim/oscilloscope_bd_ila_0_0.vhd" \
  "../../../bd/oscilloscope_bd/ipshared/6d8d/hdl/OsciToCpu_v1_S00_AXI.vhd" \
  "../../../bd/oscilloscope_bd/ipshared/6d8d/hdl/OsciToCpu_v1.vhd" \
  "../../../bd/oscilloscope_bd/ip/oscilloscope_bd_OsciToCpu_0_3/sim/oscilloscope_bd_OsciToCpu_0_3.vhd" \
  "../../../bd/oscilloscope_bd/ip/oscilloscope_bd_adc_processing_0_1/sim/oscilloscope_bd_adc_processing_0_1.vhd" \
  "../../../bd/oscilloscope_bd/ip/oscilloscope_bd_osci_0_1/sim/oscilloscope_bd_osci_0_1.vhd" \
-endlib
-makelib ies_lib/generic_baseblocks_v2_1_0 \
  "../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_5 \
  "../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/276e/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_5 \
  "../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/276e/hdl/fifo_generator_v13_2_rfs.vhd" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_5 \
  "../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/276e/hdl/fifo_generator_v13_2_rfs.v" \
-endlib
-makelib ies_lib/axi_data_fifo_v2_1_23 \
  "../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/94ec/hdl/axi_data_fifo_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_register_slice_v2_1_24 \
  "../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/8f68/hdl/axi_register_slice_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_protocol_converter_v2_1_24 \
  "../../../../Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ipshared/6e0d/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/oscilloscope_bd/ip/oscilloscope_bd_auto_pc_0/sim/oscilloscope_bd_auto_pc_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/oscilloscope_bd/sim/oscilloscope_bd.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

