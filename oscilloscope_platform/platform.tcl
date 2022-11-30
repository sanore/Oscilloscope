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
