
 add_fsm_encoding \
       {montgomery.state} \
       { }  \
       {{0000 0000} {0001 0001} {0010 0010} {0011 0011} {0100 0100} {0101 0101} {0110 0110} {0111 0111} {1000 1000} {1001 1001} }

 add_fsm_encoding \
       {montgomery_wrapper.r_state} \
       { }  \
       {{0000 000} {0001 111} {0010 100} {0011 101} {0100 110} {1010 001} {1011 010} {1100 011} }

 add_fsm_encoding \
       {axi_data_fifo_v2_1_8_axic_reg_srl_fifo.state} \
       { }  \
       {{00 0100} {01 1000} {10 0001} {11 0010} }
