# This file is automatically generated.
# It contains project source information necessary for synthesis and implementation.

# TCL: /users/start2016/r0594518/Desktop/Merger/package/rsa-project/src/constraints/constraints.tcl

# Block Designs: bd/rsa_project/rsa_project.bd
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project || ORIG_REF_NAME==rsa_project}]

# IP: bd/rsa_project/ip/rsa_project_Montgomery_Interface_0_0/rsa_project_Montgomery_Interface_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project_Montgomery_Interface_0_0 || ORIG_REF_NAME==rsa_project_Montgomery_Interface_0_0}]

# IP: bd/rsa_project/ip/rsa_project_axi_dma_0_0/rsa_project_axi_dma_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project_axi_dma_0_0 || ORIG_REF_NAME==rsa_project_axi_dma_0_0}]

# IP: bd/rsa_project/ip/rsa_project_axi_mem_intercon_0/rsa_project_axi_mem_intercon_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project_axi_mem_intercon_0 || ORIG_REF_NAME==rsa_project_axi_mem_intercon_0}]

# IP: bd/rsa_project/ip/rsa_project_axis_to_bram_0_0/rsa_project_axis_to_bram_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project_axis_to_bram_0_0 || ORIG_REF_NAME==rsa_project_axis_to_bram_0_0}]

# IP: bd/rsa_project/ip/rsa_project_montgomery_wrapper_0_0/rsa_project_montgomery_wrapper_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project_montgomery_wrapper_0_0 || ORIG_REF_NAME==rsa_project_montgomery_wrapper_0_0}]

# IP: bd/rsa_project/ip/rsa_project_processing_system7_0_0/rsa_project_processing_system7_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project_processing_system7_0_0 || ORIG_REF_NAME==rsa_project_processing_system7_0_0}]

# IP: bd/rsa_project/ip/rsa_project_processing_system7_0_axi_periph_0/rsa_project_processing_system7_0_axi_periph_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project_processing_system7_0_axi_periph_0 || ORIG_REF_NAME==rsa_project_processing_system7_0_axi_periph_0}]

# IP: bd/rsa_project/ip/rsa_project_xbar_0/rsa_project_xbar_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project_xbar_0 || ORIG_REF_NAME==rsa_project_xbar_0}]

# IP: bd/rsa_project/ip/rsa_project_rst_processing_system7_0_100M_0/rsa_project_rst_processing_system7_0_100M_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project_rst_processing_system7_0_100M_0 || ORIG_REF_NAME==rsa_project_rst_processing_system7_0_100M_0}]

# IP: bd/rsa_project/ip/rsa_project_auto_pc_0/rsa_project_auto_pc_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project_auto_pc_0 || ORIG_REF_NAME==rsa_project_auto_pc_0}]

# IP: bd/rsa_project/ip/rsa_project_auto_us_0/rsa_project_auto_us_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project_auto_us_0 || ORIG_REF_NAME==rsa_project_auto_us_0}]

# IP: bd/rsa_project/ip/rsa_project_auto_pc_1/rsa_project_auto_pc_1.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project_auto_pc_1 || ORIG_REF_NAME==rsa_project_auto_pc_1}]

# IP: bd/rsa_project/ip/rsa_project_auto_pc_2/rsa_project_auto_pc_2.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project_auto_pc_2 || ORIG_REF_NAME==rsa_project_auto_pc_2}]

# IP: bd/rsa_project/ip/rsa_project_auto_pc_3/rsa_project_auto_pc_3.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project_auto_pc_3 || ORIG_REF_NAME==rsa_project_auto_pc_3}]

# IP: bd/rsa_project/ip/rsa_project_auto_pc_4/rsa_project_auto_pc_4.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==rsa_project_auto_pc_4 || ORIG_REF_NAME==rsa_project_auto_pc_4}]

# XDC: bd/rsa_project/ip/rsa_project_axi_dma_0_0/rsa_project_axi_dma_0_0_ooc.xdc

# XDC: bd/rsa_project/ip/rsa_project_axi_dma_0_0/rsa_project_axi_dma_0_0.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==rsa_project_axi_dma_0_0 || ORIG_REF_NAME==rsa_project_axi_dma_0_0}] {/U0 }]/U0 ]]

# XDC: bd/rsa_project/ip/rsa_project_axi_dma_0_0/rsa_project_axi_dma_0_0_clocks.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==rsa_project_axi_dma_0_0 || ORIG_REF_NAME==rsa_project_axi_dma_0_0}] {/U0 }]/U0 ]]

# XDC: bd/rsa_project/ip/rsa_project_processing_system7_0_0/rsa_project_processing_system7_0_0.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==rsa_project_processing_system7_0_0 || ORIG_REF_NAME==rsa_project_processing_system7_0_0}] {/inst }]/inst ]]

# XDC: bd/rsa_project/ip/rsa_project_xbar_0/rsa_project_xbar_0_ooc.xdc

# XDC: bd/rsa_project/ip/rsa_project_rst_processing_system7_0_100M_0/rsa_project_rst_processing_system7_0_100M_0_board.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==rsa_project_rst_processing_system7_0_100M_0 || ORIG_REF_NAME==rsa_project_rst_processing_system7_0_100M_0}] {/U0 }]/U0 ]]

# XDC: bd/rsa_project/ip/rsa_project_rst_processing_system7_0_100M_0/rsa_project_rst_processing_system7_0_100M_0.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==rsa_project_rst_processing_system7_0_100M_0 || ORIG_REF_NAME==rsa_project_rst_processing_system7_0_100M_0}] {/U0 }]/U0 ]]

# XDC: bd/rsa_project/ip/rsa_project_rst_processing_system7_0_100M_0/rsa_project_rst_processing_system7_0_100M_0_ooc.xdc

# XDC: bd/rsa_project/ip/rsa_project_auto_pc_0/rsa_project_auto_pc_0_ooc.xdc

# XDC: bd/rsa_project/ip/rsa_project_auto_us_0/rsa_project_auto_us_0_ooc.xdc

# XDC: bd/rsa_project/ip/rsa_project_auto_us_0/rsa_project_auto_us_0_clocks.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==rsa_project_auto_us_0 || ORIG_REF_NAME==rsa_project_auto_us_0}] {/inst }]/inst ]]

# XDC: bd/rsa_project/ip/rsa_project_auto_pc_1/rsa_project_auto_pc_1_ooc.xdc

# XDC: bd/rsa_project/ip/rsa_project_auto_pc_2/rsa_project_auto_pc_2_ooc.xdc

# XDC: bd/rsa_project/ip/rsa_project_auto_pc_3/rsa_project_auto_pc_3_ooc.xdc

# XDC: bd/rsa_project/ip/rsa_project_auto_pc_4/rsa_project_auto_pc_4_ooc.xdc

# XDC: bd/rsa_project/rsa_project_ooc.xdc
