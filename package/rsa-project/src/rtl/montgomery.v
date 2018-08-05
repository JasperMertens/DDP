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
    parameter STATES = 9;
    parameter STATESBITS = 4;
    parameter IDLE =                4'b0000,  // state 0
              FORLOOP =             4'b0001,  // state 1
              INFORLOOP =           4'b0010,  // state 2
              INLOOPSHIFT =         4'b0011,  // state 3
              INLOOPADDSHIFT =      4'b0100,  // state 4
              INLOOPADDSHIFTWAIT =  4'b0101,  // state 5
              MODULOCHECK =         4'b0110,  // state 6
              MODULOCHECKWAIT =     4'b0111,  // state 7
              CHOOSERESULT =        4'b1000,  // state 8
              STOP =                4'b1001;  // state 9
    reg [STATESBITS-1:0]    state;
    reg [STATESBITS-1:0]    next_state;  
    
    reg [9:0] i;
    reg [n-1:0] a, b, m;
    wire [n+1:0] c;
    assign c = result_a;
    assign in_a_a = state == IDLE ? {514{1'b0}} : result_a;
    reg [513:0] reg_result;         
    reg [12:0] cyclecounter;
    
    assign done = (state == STOP);
    
    wire [513:0] idlewire, forloopwire, inforloopwire, modulocheckwire;
    
    assign idlewire = {514{1'b0}};
    assign forloopwire = a[i] ? b : {514{1'b0}};
    assign inforloopwire = c[0] ? m : {514{1'b0}};
    assign modulocheckwire = m;
    
    assign in_b_a = state == IDLE ? idlewire : (state == FORLOOP ? forloopwire : (state == INFORLOOP ? inforloopwire : (state == MODULOCHECK ? modulocheckwire : {514{1'b0}}))) ;
    
    assign result = c[511:0];    
  
    // FSM next state combo logic
    always @(state or start or done_a)
    begin : FSM_COMBO
        //next_state = 9'b000000000;
        case(state)
        IDLE:                                           // STATE 0
            if (start == 1'b1)
                next_state <= FORLOOP;
            else 
                next_state <= IDLE;

        FORLOOP:                                        // STATE 1
            next_state <= INFORLOOP;

        INFORLOOP:                                    // STATE 2
            if (i == 512) next_state = MODULOCHECK;
            else next_state <= FORLOOP;     

        MODULOCHECK:                                    // STATE 6
            next_state <= STOP;
            
        STOP:
            next_state <= IDLE;
                                   
        default : next_state <= IDLE;
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
    
    // FSM Output logic
    always @ (posedge clk)
    begin : FSM_OUT
    if (resetn == 1'b0) begin
        start_a <= 1'b0;
        cyclecounter <= {12{1'b0}};
        // assign resetn_a = resetn; check iets naar boven
    end
    else begin 
        cyclecounter <= cyclecounter + 1;
        case(state)
        IDLE: 
            begin
                if (start) start_a <= 1'b1;
                else start_a <= 1'b0;
                shift_a <= 1'b0;
                subtract_a <= 1'b0;
                cyclecounter <= {12{1'b0}};
            end              
        FORLOOP: 
            begin
                start_a <= 1'b1;
                subtract_a <= 1'b0;
                shift_a <= 1'b0;
            end
        INFORLOOP: 
            begin
                start_a <= 1'b1;
                shift_a <= 1'b1;
                subtract_a <= 1'b0;
            end
        MODULOCHECK:
            begin
                start_a <= 1'b1;
                shift_a <= 1'b0;
                subtract_a <= 1'b1;
            end
        STOP:
            begin
                start_a <= 1'b0;
            end
       endcase
    end
    end
    
    
    // datapath
    always @(posedge clk)
    begin : DATAPATH
        if (resetn==1'b0) begin
            //c <= {(n+2){1'b0}};
            i <= {9{1'b0}};
        end
        else begin
            case(state)
                IDLE:
                begin
                    //c <= {(n+2){1'b0}};
                    //if (start) i <= 1'b1;
                    //else i <= {9{1'b0}};
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
                    //c <= result_a;
                end
                MODULOCHECK:
                begin
                    reg_result <= result_a[513:0];
                end
                STOP:
                begin
                    
                end
            endcase    
        end
    end    
endmodule