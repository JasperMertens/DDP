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
    
   
    parameter n = 52;
    wire [n-1:0] A0, A1, A2, A3, A4, A5, A6, A7, A8, A9;
    wire [n-1:0] B0, B1, B2, B3, B4, B5, B6, B7, B8, B9;
//    wire [513:0] testA, testB;
    wire [n:0] S0, S10, S20, S30, S40, S50, S60, S70, S80, S90;
    wire [n:0]     S11, S21, S31, S41, S51, S61, S71, S81, S91;
    wire C1, C2, C3, C4, C5, C6, C7, C8, C9;
    wire [n-1:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9;
    wire [514:0] resultwire;
    reg [514:0] result_reg;
    
    wire [513:0] in_b_;
    assign in_b_ = subtract ? ~in_b : in_b;
    
    assign A0 = in_a[n-1:0];
    assign A1 = in_a[2*n-1:n];
    assign A2 = in_a[3*n-1:2*n];
    assign A3 = in_a[4*n-1:3*n];
    assign A4 = in_a[5*n-1:4*n];
    assign A5 = in_a[6*n-1:5*n];
    assign A6 = in_a[7*n-1:6*n];
    assign A7 = in_a[8*n-1:7*n];
    assign A8 = in_a[9*n-1:8*n];
    assign A9 = {6'b000000, in_a[10*n-7:9*n]};

    assign B0 = in_b_[n-1:0];
    assign B1 = in_b_[2*n-1:n];
    assign B2 = in_b_[3*n-1:2*n];
    assign B3 = in_b_[4*n-1:3*n];
    assign B4 = in_b_[5*n-1:4*n];
    assign B5 = in_b_[6*n-1:5*n];
    assign B6 = in_b_[7*n-1:6*n];
    assign B7 = in_b_[8*n-1:7*n];
    assign B8 = in_b_[9*n-1:8*n];
    assign B9 = {6'b000000, in_b_[10*n-7:9*n]};
    
    assign S0  = A0 + B0 + subtract;
    
    assign S10 = A1 + B1;
    assign S20 = A2 + B2;
    assign S30 = A3 + B3;
    assign S40 = A4 + B4;
    assign S50 = A5 + B5;
    assign S60 = A6 + B6;
    assign S70 = A7 + B7;
    assign S80 = A8 + B8;
    assign S90 = A9 + B9;
    
    assign S11 = A1 + B1 + 1'b1;
    assign S21 = A2 + B2 + 1'b1;
    assign S31 = A3 + B3 + 1'b1;
    assign S41 = A4 + B4 + 1'b1;
    assign S51 = A5 + B5 + 1'b1;
    assign S61 = A6 + B6 + 1'b1;
    assign S71 = A7 + B7 + 1'b1;
    assign S81 = A8 + B8 + 1'b1;
    assign S91 = A9 + B9 + 1'b1;

    //assign C1 = subtract ? S01[n] : S00[n];
    assign C1 =       S0[n];
    assign C2 = C1 ? S11[n] : S10[n];
    assign C3 = C2 ? S21[n] : S20[n];
    assign C4 = C3 ? S31[n] : S30[n];
    assign C5 = C4 ? S41[n] : S40[n];
    assign C6 = C5 ? S51[n] : S50[n];
    assign C7 = C6 ? S61[n] : S60[n];
    assign C8 = C7 ? S71[n] : S70[n];
    assign C9 = C8 ? S81[n] : S80[n];
    assign carry = C9 ? S91[46] : S90[46];
   
    //assign R0 = subtract ? S01[n-1:0] : S00[n-1:0];
    assign R0 =       S0[n-1:0];
    assign R1 = C1 ? S11[n-1:0] : S10[n-1:0];
    assign R2 = C2 ? S21[n-1:0] : S20[n-1:0];
    assign R3 = C3 ? S31[n-1:0] : S30[n-1:0];
    assign R4 = C4 ? S41[n-1:0] : S40[n-1:0];     
    assign R5 = C5 ? S51[n-1:0] : S50[n-1:0];            
    assign R6 = C6 ? S61[n-1:0] : S60[n-1:0];            
    assign R7 = C7 ? S71[n-1:0] : S70[n-1:0];            
    assign R8 = C8 ? S81[n-1:0] : S80[n-1:0];            
    assign R9 = C9 ? S91[n-1:0] : S90[n-1:0];            
       
    
    assign resultwire = shift? {1'b0, (carry^subtract), R9[45:0], R8, R7, R6, R5, R4, R3, R2, R1, R0[n-1:1]} : {(carry^subtract), R9[45:0], R8, R7, R6, R5, R4, R3, R2, R1, R0};
    assign result = result_reg;       
    
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


/*
    parameter n = 172;
    parameter STATES = 5;
    parameter STATESBITS = 3;
    parameter IDLE  =     3'b000,  // state 0
              CALC1 =     3'b001,  // state 1
              CALC2 =     3'b010,  // state 2
              CALC3 =     3'b011,  // state 3
              SHIFT =     3'b100,
              DONE  =     3'b101;  

    reg [STATESBITS-1:0]    state;
    reg [STATESBITS-1:0]    next_state;
    
    reg shifted;
    assign done = (state == DONE);
    
    reg [513:0] in_a_reg, in_b_reg;
    reg [n-1:0] a,b;
    wire [n:0] add_out;
    wire [514:0] resultwire;
    wire [514:0] result_shifted;
    assign add_out = a + b + carry;
    reg c;
    assign carry = c;
    reg [515:0] result_reg;
    
    assign result_reg_out   = result_reg[515:0];
    assign resultwire       = result_reg[514:0]; 
    assign result_shifted   = {1'b0,result_reg[514:1]};
        //assign out_result       = (state == DONE) ? (shift ? result_shifted : result) : {515{1'b0}} ;
    assign result           = shift ? result_shifted : resultwire;

    
    always @(state or start or shift)
    begin : FSM_COMBO
        case(state)
        IDLE:
            if (start == 1'b1)
                next_state = CALC1;
            else  
                next_state = IDLE;
        
        CALC1:
            next_state = CALC2;
        
        CALC2:
            next_state = CALC3;
        
        CALC3:
            if (shifted == 1) next_state = SHIFT;
            else next_state = DONE;
        
        SHIFT:
            next_state = DONE;
        
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
            in_a_reg   <= {(514){1'b0}};
            in_b_reg   <= {(514){1'b0}};
            a          <= {(n){1'b0}};
            b          <= {(n){1'b0}};
            c          <= 1'b0;
            result_reg <= {(516){1'b0}};
            shifted    <= 1'b0;
        end
        
        else begin
            case(state)
            
                IDLE:
                begin
                // result_reg niet clearen omdat het kan dat we nog moeten shiften!
                    if (start == 1) begin
                        result_reg <= {(516){1'b0}};
                        in_a_reg   <= in_a;
                        a          <= in_a[n-1:0];
                        c          <= subtract;
                        if (subtract == 1'b1)           begin
                            in_b_reg   <= ~in_b;
                            b          <= ~in_b[n-1:0]; end
                        else                            begin
                            in_b_reg   <= in_b;
                            b          <= in_b[n-1:0];  end
                        if (shift == 1) shifted <= 1'b1;
                        else shifted <= 1'b0;
                    end
                end
                
                CALC1:
                begin
                    c <= add_out[n];
                    result_reg <= {add_out[n-1:0], result_reg[515:n]};
                    a <= in_a_reg[(2*n)-1:n];
                    //if (subtract == 1'b0) b <= in_b_reg[(2*nb_bits)-1:nb_bits];
                    //else b <= ~in_b_reg[(2*nb_bits)-1:nb_bits];
                    b <= in_b_reg[(2*n)-1:n];
                end
                
                CALC2:
                begin
                    c <= add_out[n];
                    result_reg <= {add_out[n-1:0], result_reg[515:n]};
                    a <= in_a_reg[(3*n)-3:2*n];
                    //if (subtract == 1'b0) b <= in_b_reg[(3*nb_bits)-3:2*nb_bits];
                    //else b <= ~in_b_reg[(3*nb_bits)-3:2*nb_bits];
                    b <= in_b_reg[(3*n)-3:2*n];
                end
                
                CALC3:
                begin 
                    //result_reg <= {add_out[n-1:0], result_reg[515:n]};
                    result_reg <= {0, (subtract^add_out[n-2]) , add_out[n-3:0], result_reg[515:n]};
                end
                
                SHIFT:
                begin
                    result_reg <= {1'b0, result_reg[515:1]};
                end
                
                DONE:
                begin
                
                end
            endcase
        end
    end
endmodule

*/