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
                    if (subtract == 1'b0) b <= in_b_reg[(2*n)-1:n];
                    else b <= ~in_b_reg[(2*n)-1:n];
                end
                
                CALC2:
                begin
                    c <= add_out[n];
                    result_reg <= {add_out[n-1:0], result_reg[515:n]};
                    a <= in_a_reg[(3*n)-3:2*n];
                    //if (subtract == 1'b0) b <= in_b_reg[(3*nb_bits)-3:2*nb_bits];
                    //else b <= ~in_b_reg[(3*nb_bits)-3:2*nb_bits];
                    if (subtract == 1'b0) b <= in_b_reg[(3*n)-3:2*n];
                    else b <= ~in_b_reg[(3*n)-3:2*n];
                end
                
                CALC3:
                begin 
                    result_reg <= {add_out[n-1:0], result_reg[515:n]};
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