
 add_fsm_encoding \
       {montgomery.state} \
       { }  \
       {{000 000} {001 001} {010 010} {011 011} {100 100} }

 add_fsm_encoding \
       {montgomery_wrapper.r_state} \
       { }  \
       {{0000 000} {0001 111} {0010 100} {0011 101} {0100 110} {1010 001} {1011 010} {1100 011} }

 add_fsm_encoding \
       {axi_data_fifo_v2_1_8_axic_reg_srl_fifo.state} \
       { }  \
       {{00 0100} {01 1000} {10 0001} {11 0010} }
