`timescale 1ns / 1ps

module adder(
    input  wire         clk,
    input  wire         resetn,
    input  wire         start,
    input  wire         subtract,
    input  wire         shift,
    input  wire [513:0] in_a,
    input  wire [513:0] in_b,
    output wire [514:0] result,
    output wire         done,    
    output wire         carry
    );

    // To implement the montgomery multiplication algorithm, 
    // a small change needs to be made in the input/output sizes of the adder.v
    //
    // Your adder's input and output size should be increased by 1-bit.
    // In the end, you are going to add two 514-bit input and calculate a 515-bit output.
    //
    // A second alteration is needed to accomodate the shift into your design.
    // The shift input is defined above for you.
    //
    // For this implementation, revisit your previous adder design, copy it here,
    // and do alteration to make it compatible with the input/output size as defined above.
    //
    // The tb_adder.v and testvector generator script are already updated for the changes.
    //
    // assign result = in_a + in_b;
    // assign done = 1'b1;
    
//    parameter n = 103;
//    wire [n-1:0] A0, A1, A2, A3, A4;
//    wire [n-1:0] B0, B1, B2, B3, B4;
////    wire [513:0] testA, testB;
//    wire [n:0] S0, S10, S20, S30, S40;
//    wire [n:0]     S11, S21, S31, S41;
//    wire C1, C2, C3, C4;
//    wire [n-1:0] R0, R1, R2, R3, R4;
//    wire [514:0] resultwire;
//    reg [514:0] result_reg;
    
//    assign A0 = in_a[n-1:0];
//    assign A1 = in_a[2*n-1:n];
//    assign A2 = in_a[3*n-1:2*n];
//    assign A3 = in_a[4*n-1:3*n];
//    assign A4 = in_a[5*n-2:4*n];
////    assign testA = {A4, A3, A2, A1, A0};

//    assign B0 = in_b[n-1:0];
//    assign B1 = in_b[2*n-1:n];
//    assign B2 = in_b[3*n-1:2*n];
//    assign B3 = in_b[4*n-1:3*n];
//    assign B4 = in_b[5*n-2:4*n];
////    assign testB = {B4, B3, B2, B1, B0};
    
//    assign S0  = A0 + B0 + subtract;
//    assign S10 = A1 + B1;
//    assign S20 = A2 + B2;
//    assign S30 = A3 + B3;
//    assign S40 = A4 + B4;
    
//    //assign S01 = A0 + B0 + 1'b1;
//    assign S11 = A1 + B1 + 1'b1;
//    assign S21 = A2 + B2 + 1'b1;
//    assign S31 = A3 + B3 + 1'b1;
//    assign S41 = A4 + B4 + 1'b1;
        
//    //assign C1 = subtract ? S01[n] : S00[n];
//    assign C1 =       S0[n];
//    assign C2 = C1 ? S11[n] : S10[n];
//    assign C3 = C2 ? S21[n] : S20[n];
//    assign C4 = C3 ? S31[n] : S30[n];
    
//    //assign R0 = subtract ? S01[n-1:0] : S00[n-1:0];
//    assign R0 =       S0[n-1:0];
//    assign R1 = C1 ? S11[n-1:0] : S10[n-1:0];
//    assign R2 = C2 ? S21[n-1:0] : S20[n-1:0];
//    assign R3 = C3 ? S31[n-1:0] : S30[n-1:0];
//    assign R4 = C4 ? S41[n-1:0] : S40[n-1:0];            
    
//    assign resultwire = shift? {1'b0, R4, R3, R2, R1, R0[n-1:1]} : {R4, R3, R2, R1, R0};
//    assign result = result_reg;
//    assign carry = result_reg[514];    
    
    
    wire [53:0] A0, B0;
    wire [54:0] A1, B1;
    wire [55:0] A2, B2;
    wire [56:0] A3, B3;
    wire [57:0] A4, B4;
    wire [58:0] A5, A6, A7, A8, B5, B6, B7, B8;
    
    wire [54:0] S0;
    wire [55:0] S10, S11;
    wire [56:0] S20, S21;
    wire [57:0] S30, S31;
    wire [58:0] S40, S41;
    wire [59:0] S50, S51, S60, S61, S70, S71, S80, S81;

    wire C1, C2, C3, C4, C5, C6, C7, C8;
    
    wire [53:0] R0;
    wire [54:0] R1;
    wire [55:0] R2;
    wire [56:0] R3;
    wire [57:0] R4;
    wire [58:0] R5, R6, R7, R8;
    
    wire [514:0] resultwire;
    reg [514:0] result_reg;
    
    assign A0 = in_a[53:0];     //54
    assign A1 = in_a[108:54];   //55
    assign A2 = in_a[164:109];  //56
    assign A3 = in_a[221:165];  //57
    assign A4 = in_a[279:222];  //58
    assign A5 = in_a[338:280];  //59
    assign A6 = in_a[397:339];  //59
    assign A7 = in_a[456:398];  //59
    assign A8 = {1'b0, 1'b0, in_a[513:457]};  //59

    assign B0 = in_b[53:0];     //54
    assign B1 = in_b[108:54];   //55
    assign B2 = in_b[164:109];  //56
    assign B3 = in_b[221:165];  //57
    assign B4 = in_b[279:222];  //58
    assign B5 = in_b[338:280];  //59
    assign B6 = in_b[397:339];  //59
    assign B7 = in_b[456:398];  //59
    assign B8 = {1'b0, 1'b0, in_b[513:457]};  //59

    assign S0  = A0 + B0 + subtract;
    assign S10 = A1 + B1;
    assign S20 = A2 + B2;
    assign S30 = A3 + B3;
    assign S40 = A4 + B4;
    assign S50 = A5 + B5;
    assign S60 = A6 + B6;
    assign S70 = A7 + B7;
    assign S80 = A8 + B8;

    //assign S01 = A0 + B0 + 1'b1;
    assign S11 = A1 + B1 + 1'b1;
    assign S21 = A2 + B2 + 1'b1;
    assign S31 = A3 + B3 + 1'b1;
    assign S41 = A4 + B4 + 1'b1;
    assign S51 = A5 + B5 + 1'b1;
    assign S61 = A6 + B6 + 1'b1;
    assign S71 = A7 + B7 + 1'b1;
    assign S81 = A8 + B8 + 1'b1;
    
    //assign C1 = subtract ? S01[n] : S00[n];
    assign C1 =       S0[54];
    assign C2 = C1 ? S11[55] : S10[55];
    assign C3 = C2 ? S21[56] : S20[56];
    assign C4 = C3 ? S31[57] : S30[57];
    assign C5 = C4 ? S41[58] : S40[58];
    assign C6 = C5 ? S51[59] : S50[59];
    assign C7 = C6 ? S61[59] : S60[59];
    assign C8 = C7 ? S71[59] : S70[59];
    
    //assign R0 = subtract ? S01[n-1:0] : S00[n-1:0];
    assign R0 =       S0[53:0];
    assign R1 = C1 ? S11[54:0] : S10[54:0];
    assign R2 = C2 ? S21[55:0] : S20[55:0];
    assign R3 = C3 ? S31[56:0] : S30[56:0];
    assign R4 = C4 ? S41[57:0] : S40[57:0];        
    assign R5 = C5 ? S51[58:0] : S50[58:0];            
    assign R6 = C6 ? S61[58:0] : S60[58:0];            
    assign R7 = C7 ? S71[58:0] : S70[58:0];            
    assign R8 = C8 ? S81[58:0] : S80[58:0];            

    assign resultwire = shift? {1'b0, R8, R7, R6, R5, R4, R3, R2, R1, R0[53:1]} : {R8, R7, R6, R5, R4, R3, R2, R1, R0};
    assign result = result_reg;
    assign carry = result_reg[514];
       
    
    parameter STATES = 2;
    parameter STATESBITS = 1;
    parameter IDLE  =      1'b0,  // state 0
              DONE  =      1'b1;  
    
    assign done = state == DONE;

    reg [STATESBITS-1:0]    state;
    reg [STATESBITS-1:0]    next_state;
        
    always @(state or start)
    begin : FSM_COMBO
        case(state)
        IDLE:
            if (start == 1'b1)
                next_state = DONE;
            else  
                next_state = IDLE;
            
        DONE:
            next_state = IDLE;
        
        default : next_state = IDLE;
        endcase
    end
        
    // FSM Seq part
    always @ (posedge clk)
    begin : FSM_SEQ
        if (resetn == 1'b0) begin
          state <= IDLE;
        end else begin
          state <= next_state;
        end
    end
    
    always @(posedge clk)
    begin : DATAPATH
        if (resetn==1'b0) begin
            result_reg   <= {(514){1'b0}};
        end
        
        else begin
            case(state)
                IDLE:
                begin
                    if ((start == 1'b1) | (shift == 1'b1)) begin
                        result_reg <= resultwire;
                    end
                end
                
                DONE:
                begin
                
                end
            endcase
        end
    end
endmodule