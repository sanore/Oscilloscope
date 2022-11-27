onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+oscilloscope_bd -L xilinx_vip -L xpm -L xil_defaultlib -L xlconstant_v1_1_7 -L lib_cdc_v1_0_2 -L proc_sys_reset_v5_0_13 -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_10 -L processing_system7_vip_v1_0_12 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.oscilloscope_bd xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {oscilloscope_bd.udo}

run -all

endsim

quit -force
