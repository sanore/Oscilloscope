# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: U:\DigMe\Oscilloscope\oscilloscope_app_system\_ide\scripts\debugger_oscilloscope_app-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source U:\DigMe\Oscilloscope\oscilloscope_app_system\_ide\scripts\debugger_oscilloscope_app-default.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw U:/DigMe/Oscilloscope/oscilloscope_platform/export/oscilloscope_platform/hw/oscilloscope.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source U:/DigMe/Oscilloscope/oscilloscope_app/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow U:/DigMe/Oscilloscope/oscilloscope_app/Debug/oscilloscope_app.elf
configparams force-mem-access 0
bpadd -addr &main
