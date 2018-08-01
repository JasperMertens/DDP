# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
set_msg_config  -ruleid {1}  -id {Synth 8-327}  -new_severity {ERROR} 
set_msg_config  -ruleid {10}  -id {Vivado 12-3482}  -new_severity {INFO} 
set_msg_config  -ruleid {2}  -id {Synth 8-3352}  -new_severity {ERROR} 
set_msg_config  -ruleid {3}  -id {Synth 8-5559}  -new_severity {ERROR} 
set_msg_config  -ruleid {4}  -id {Timing 38-282}  -new_severity {ERROR} 
set_msg_config  -ruleid {5}  -id {BD 41-1343}  -new_severity {INFO} 
set_msg_config  -ruleid {6}  -id {BD_TCL-1000}  -new_severity {INFO} 
set_msg_config  -ruleid {7}  -id {IP_Flow 19-3899}  -new_severity {INFO} 
set_msg_config  -ruleid {8}  -id {IP_Flow 19-3153}  -new_severity {INFO} 
set_msg_config  -ruleid {9}  -id {IP_Flow 19-2207}  -new_severity {INFO} 
create_project -in_memory -part xc7z010clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /users/start2015/r0575928/Desktop/ddplatforms_2017/ddp_hw/rsa-project/rsa_project/rsa_project.cache/wt [current_project]
set_property parent.project_path /users/start2015/r0575928/Desktop/ddplatforms_2017/ddp_hw/rsa-project/rsa_project/rsa_project.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:zybo:part0:1.0 [current_project]
read_verilog -library xil_defaultlib {
  /users/start2015/r0575928/Desktop/ddplatforms_2017/ddp_hw/rsa-project/src/rtl/adder.v
  /users/start2015/r0575928/Desktop/ddplatforms_2017/ddp_hw/rsa-project/src/rtl/hweval_adder.v
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc -unmanaged /users/start2015/r0575928/Desktop/ddplatforms_2017/ddp_hw/rsa-project/src/constraints/constraints.tcl
set_property used_in_implementation false [get_files /users/start2015/r0575928/Desktop/ddplatforms_2017/ddp_hw/rsa-project/src/constraints/constraints.tcl]


synth_design -top hweval_adder -part xc7z010clg400-1


write_checkpoint -force -noxdef hweval_adder.dcp

catch { report_utilization -file hweval_adder_utilization_synth.rpt -pb hweval_adder_utilization_synth.pb }
