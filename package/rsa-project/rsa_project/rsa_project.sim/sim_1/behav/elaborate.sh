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
ExecStep $xv_path/bin/xelab -wto db510e6f95be439180a510813d312943 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_montgomery_behav xil_defaultlib.tb_montgomery xil_defaultlib.glbl -log elaborate.log
