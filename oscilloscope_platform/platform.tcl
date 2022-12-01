# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct U:\DigMe\Oscilloscope\oscilloscope_platform\platform.tcl
# 
# OR launch xsct and run below command.
# source U:\DigMe\Oscilloscope\oscilloscope_platform\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {oscilloscope_platform}\
-hw {U:\DigMe\Oscilloscope\project\oscilloscope.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -out {U:/DigMe/Oscilloscope}

platform write
platform generate -domains 
platform active {oscilloscope_platform}
platform generate
domain active {zynq_fsbl}
bsp reload
bsp reload
domain active {standalone_domain}
bsp reload
platform config -updatehw {U:/DigMe/Oscilloscope/project/oscilloscope.xsa}
platform generate -domains 
domain active {zynq_fsbl}
bsp reload
domain active {standalone_domain}
bsp reload
bsp config stdin "ps7_coresight_comp_0"
bsp config stdout "ps7_coresight_comp_0"
bsp write
bsp reload
catch {bsp regenerate}
domain active {zynq_fsbl}
bsp config stdin "ps7_coresight_comp_0"
bsp config stdout "ps7_coresight_comp_0"
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains standalone_domain,zynq_fsbl 
platform generate -domains standalone_domain 
domain active {standalone_domain}
bsp reload
bsp config stdin "ps7_uart_1"
bsp config stdout "ps7_uart_1"
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains standalone_domain 
platform clean
platform generate
platform config -updatehw {U:/DigMe/Oscilloscope/project/oscilloscope.xsa}
platform generate -domains 
