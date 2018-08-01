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
    reg start_a;   
    reg subtract_a;
    reg shift_a;
    wire [513:0] in_a_a;
    reg [513:0] in_b_a;
    wire [514:0] result_a;
    wire done_a;
    
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
        .done     (done_a     ));
        
                         
    parameter n = 512;
    parameter STATES = 9;
    parameter STATESBITS = 4;
    parameter IDLE =                4'b0000,  // state 0
              FORLOOP =             4'b0001,  // state 1
              FORLOOPWAIT =         4'b0010,  // state 2
              INLOOPSHIFT =         4'b0011,  // state 3
              INLOOPADDSHIFT =      4'b0100,  // state 4
              INLOOPADDSHIFTWAIT =  4'b0101,  // state 5
              MODULOCHECK =         4'b0110,  // state 6
              MODULOCHECKWAIT =     4'b0111,  // state 7
              FINISH =              4'b1000;  // state 8
              
    reg [9:0] i;
    reg [n-1:0] a, b, m;
    reg [n+1:0] c;
    assign in_a_a = c;
    

    reg [STATESBITS-1:0]    state;
    reg [STATESBITS-1:0]    next_state;
    
    assign done = (state == FINISH);
  
    // FSM next state combo logic
    always @(state or start or done_a)
    begin : FSM_COMBO
        //next_state = 9'b000000000;
        case(state)
        IDLE:                                           // STATE 0
            if (start == 1'b1)
                next_state = FORLOOP;
            else 
                next_state = IDLE;

        FORLOOP:                                        // STATE 1
            next_state = FORLOOPWAIT;
            
        FORLOOPWAIT:                                    // STATE 2
            if (done_a) begin
                //if (c[0] == 1'b0)
                if (result_a[0] == 1'b0)
                    next_state = INLOOPSHIFT;
                else 
                    next_state = INLOOPADDSHIFT;
            end
            else 
                next_state = FORLOOPWAIT;        

        INLOOPSHIFT:                                    // STATE 3          
            if (i < n)
                next_state = FORLOOP;
            else 
                next_state = MODULOCHECK;
                
        INLOOPADDSHIFT:                                 // STATE 4
            next_state = INLOOPADDSHIFTWAIT;
             
        INLOOPADDSHIFTWAIT:                             // STATE 5
            if (done_a == 1'b1) begin
                if (i < n)
                    next_state = FORLOOP;
                else 
                    next_state = MODULOCHECK;            
            end
            else
                next_state = INLOOPADDSHIFTWAIT;
        
        MODULOCHECK:                                    // STATE 6
            next_state = MODULOCHECKWAIT;
         
        MODULOCHECKWAIT:                                // STATE 7
            if (done_a == 1'b1) 
                next_state = FINISH;
            else
                next_state = MODULOCHECKWAIT;
                
        FINISH:                                         // STATE 8
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
    
    
    
    // FSM Output logic
    always @ (posedge clk)
    begin : FSM_OUT
    if (resetn == 1'b0) begin
        start_a <= 1'b0;
        // assign resetn_a = resetn; check iets naar boven
    end
    else begin 
        case(state)
        IDLE: 
            begin
                start_a <= 1'b0;
                shift_a <= 1'b0;
                subtract_a <= 1'b0;
            end              
        FORLOOP: 
            begin
                start_a <= 1'b1;
                subtract_a <= 1'b0;
                shift_a <= 1'b0;
            end
        FORLOOPWAIT: 
            begin
                start_a <= 1'b0;
            end
        INLOOPSHIFT: 
            begin
                start_a <= 1'b0;
            end
        INLOOPADDSHIFT:
            begin
                start_a <= 1'b1;                
                subtract_a <= 1'b0;
                shift_a <= 1'b1;
            end
        INLOOPADDSHIFTWAIT:
            begin
                start_a <= 1'b0;
            end
        MODULOCHECK:
            begin
                start_a <= 1'b1;       
                subtract_a <= 1'b1;
                shift_a <= 1'b0;
            end
        MODULOCHECKWAIT:
            begin
                start_a <= 1'b0;
            end
        FINISH:
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
            c <= {(n+2){1'b0}};
            i <= {9{1'b0}};
        end
        else begin
            case(state)
                IDLE:
                begin
                    c <= {(n+2){1'b0}};
                    i <= {9{1'b0}};
                    a <= in_a;
                    b <= in_b;
                    m <= in_m;
                end
                FORLOOP:
                begin 
                    if (a[i] == 1'b1)
                        in_b_a <= b;  // select_mb == 0
                    else 
                        in_b_a <= {514{1'b0}};
                    i <= i + 1;
                end
                FORLOOPWAIT:
                begin
                    c <= result_a;
                end
                INLOOPSHIFT:
                begin
                    c <= c >> 1;
                end
                INLOOPADDSHIFT:
                begin
                    in_b_a <= m; //  select_mb == 1
                end
                INLOOPADDSHIFTWAIT:
                begin
                    c <= result_a;
                end
                MODULOCHECK:
                begin
                    in_b_a <= m; //  select_mb == 1
                end
                MODULOCHECKWAIT:
                begin
                end
                FINISH:
                begin 
                    c <= result_a[514] ? result_a : c;
                end
            
            endcase    
        end
    end
        
    assign result = done ? c[511:0] : {512{1'b0}};    
        
    /*
    //This always block was added to ensure the tool doesn't trim away the montgomery module.
    //Students: Feel free to remove this block
    
    reg [511:0] r_result;
    always @(posedge(clk))
    begin
        r_result <= {512{1'b1}};
    end
    assign result = r_result;

    assign done = 1;
    */
    
endmodule