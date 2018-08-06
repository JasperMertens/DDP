`timescale 1ns / 1ps

module montgomery(
    input          clk,
    input          resetn,
    input          start,
    input  [511:0] in_a,
    input  [511:0] in_b,
    input  [511:0] in_m,
    output [511:0] result,  
    output         done
    );
 
    /*
    Student tasks:
    1. Instantiate an Adder
    2. Use the Adder to implement the Montgomery multiplier in hardware.
    3. Use tb_montgomery.v to simulate your design.
    */
    
    // adder
    // reg clk;
    // reg resetn_a;
    reg             start_a;   
    reg             subtract_a;
    reg             shift_a;
    wire [513:0]    in_a_a;
    wire [513:0]    in_b_a;
    wire [514:0]    result_a;
    wire            done_a;
    wire            carry_a;
    
    // Instantiating adder
    adder dut (
        .clk      (clk        ),
        .resetn   (resetn     ),
        .start    (start_a    ),
        .subtract (subtract_a ),
        .shift    (shift_a    ),
        .in_a     (in_a_a     ),
        .in_b     (in_b_a     ),
        .result   (result_a   ),
        .done     (done_a     ),
        .carry    (carry_a    ));
                         
    parameter n = 512;
    parameter STATES = 5;
    parameter STATESBITS = 3;
    parameter IDLE =                3'b000,  // state 0
              FORLOOP =             3'b001,  // state 1
              INFORLOOP =           3'b010,  // state 2
              MODULOCHECK =         3'b011,  // state 3
              STOP =                3'b100;  // state 4
    reg [STATESBITS-1:0]    state;
    reg [STATESBITS-1:0]    next_state;  
    
    reg [9:0] i;
    reg [n-1:0] a, b, m;
    
    assign in_a_a = ((state == IDLE) | (state == STOP)) ? {514{1'b0}} : result_a;
    
    reg [513:0] reg_result;         
    reg [12:0] cyclecounter;
    
    reg [513:0] in_b_a_reg = {514{1'b0}};
    reg control = 1'b1;
    wire [513:0] in_b_a_wire;
    
    assign done = (state == STOP);

    assign modulocheckwire = m;
    
    assign in_b_a = control ? in_b_a_reg : in_b_a_wire;
   
    assign in_b_a_wire = result_a[0] ? m : {514{1'b0}};
            
    assign result = result_a[512] ? reg_result[511:0] : result_a[511:0];    
  
    // FSM next state combo logic
    always @(state or start)
    begin : FSM_COMBO
        case(state)
        IDLE:                                           // STATE 0
            if (start == 1'b1) next_state <= FORLOOP;
            else               next_state <= IDLE;

        FORLOOP:                                        // STATE 1
            next_state <= INFORLOOP;

        INFORLOOP:                                      // STATE 2
            if (i == 512) next_state <= MODULOCHECK;
            else next_state <= FORLOOP;     

        MODULOCHECK:                                    // STATE 3
            next_state <= STOP;
            
        STOP:                                           // STATE 4
            next_state <= IDLE;
                                   
        default : next_state <= IDLE;
        endcase
    end
    
    // FSM Seq part
    always @ (posedge clk)
    begin : FSM_SEQ
        if (resetn == 1'b0) state <= IDLE;
        else                state <= next_state;
    end
    
    // FSM Output logic
    always @ (posedge clk)
    begin : FSM_OUT
    if (resetn == 1'b0) begin
        start_a <= 1'b0;
        cyclecounter <= {12{1'b0}};
    end
    else begin 
        cyclecounter <= cyclecounter + 1;
        case(state)
        IDLE: 
            begin
                if (start == 1'b1) begin 
                    if (in_a[0] == 1'b1) begin
                        in_b_a_reg <= in_b;
                        start_a <= 1'b1;
                    end
                    else begin
                        in_b_a_reg <= {513{1'b0}};
                        start_a <= 1'b0;
                    end
                end
                else begin 
                    in_b_a_reg <= {513{1'b0}};
                    start_a <= 1'b0;
                end
                shift_a <= 1'b0;
                subtract_a <= 1'b0;
                cyclecounter <= {12{1'b0}};
                control <= 1'b1;
            end              
        FORLOOP: 
            begin
                start_a <= 1'b1;
                shift_a <= 1'b1;
                subtract_a <= 1'b0;
                control <= 1'b0;
            end
        INFORLOOP: 
            begin
                shift_a <= 1'b0;
                control <= 1'b1;
                if (i <= n-1) begin
                    subtract_a <= 1'b0;
                    if (a[i] == 1'b1) begin
                        in_b_a_reg <= b;
                        start_a <= 1'b1;
                    end
                    else begin
                        in_b_a_reg <= {513{1'b0}};
                        start_a <= 1'b0;
                    end
                end
                else begin
                    in_b_a_reg <= m;
                    start_a <= 1'b1;
                    subtract_a <= 1'b1;
                end
            end
        MODULOCHECK:
            begin
                in_b_a_reg <= {514{1'b0}};
                start_a <= 1'b0;
                shift_a <= 1'b0;
                subtract_a <= 1'b0;
                control <= 1'b1;
            end
        STOP:
            begin
                start_a <= 1'b1;
                shift_a <= 1'b0;
                subtract_a <= 1'b0;
                control <= 1'b1;
            end
       endcase
    end
    end
    
    
    // datapath
    always @(posedge clk)
    begin : DATAPATH
        if (resetn==1'b0) begin
            i <= {9{1'b0}};
        end
        else begin
            case(state)
                IDLE:
                begin
                    i <= {9{1'b0}};
                    a <= in_a;
                    b <= in_b;
                    m <= in_m;
                end
                FORLOOP:
                begin 
                    i <= i + 1;
                end
                INFORLOOP:
                begin
                    reg_result <= {514{1'b0}};
                end
                MODULOCHECK:
                begin
                    reg_result <= result_a[513:0];
                end
                STOP:
                begin
       //             in_b_a_reg <= {514{1'b0}};   Causes multi-driven net
                end
            endcase    
        end
    end    
endmodule