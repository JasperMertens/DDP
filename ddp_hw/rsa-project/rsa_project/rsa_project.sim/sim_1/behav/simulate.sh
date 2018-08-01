#!/bin/bash -f
xv_path="/esat/micas-data/software/xilinx_vivado_2016.2/Vivado/2016.2"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim tb_adder_behav -key {Behavioral:sim_1:Functional:tb_adder} -tclbatch tb_adder.tcl -view /users/start2015/r0575928/Desktop/ddplatforms_2017/ddp_hw/rsa-project/rsa_project/tb_adder_behav.wcfg -log simulate.log
