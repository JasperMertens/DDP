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
    
    
    reg [2:0] count = 3'b000;
    reg c;
    assign carry = c;
    reg keep_result;
    reg [513:0] in_a_reg, in_b_reg;
    
    reg [515:0] reg_result;
    reg [515:0] testresultreg;
    
    wire [nb_bits:0] add_out;
    assign add_out = a + b + c;
    
    wire [515:0] resultwire;
    
    assign resultwire = keep_result ? reg_result[515:0] : {add_out[nb_bits-1:0], reg_result[515:nb_bits]};
    
//    wire [515:0] shiftwire;
//    assign shiftwire = {1'b0,resultwire[515:1]};
    
    //assign res_shift = shift ? {1'b0,resultwire[515:1]} : resultwire[515:0];
    //assign res_shift = resultwire[514:0];
    
    //assign result= {(c^subtract), reg_result[515:0]};   // XOR the carry bit with substract
    //assign result = shift ? {c, 1'b0,resultwire[514:1]} : {c,reg_result[514:0]};
    assign result = shift ? {c,resultwire[514:1]} : {c,reg_result[513:0]};
    
    assign done = (count == 3'b100);
    
    parameter n             = 513;
    parameter nb_bits       = 172;
    parameter STATES        = 4;
    parameter STATESBITS    = 2;
    parameter IDLE          = 4'b0000,  // state 0
              START         = 4'b0001,  // state 1
              ITERATE       = 4'b0010,  // state 2
              STOP          = 4'b0011,  // state 3
                            
    reg [nb_bits-1:0] a, b;    
    
    reg [513:0] reg_result;

    reg [STATESBITS-1:0]    state;
    reg [STATESBITS-1:0]    next_state;
    
    assign done = (state == STOP);
  
    // FSM next state combo logic
    always @(state or start or done_a)
    begin : FSM_COMBO
        //next_state = 9'b000000000;
        case(state)
        IDLE:                                           // STATE 0
            if (start == 1'b1)
                next_state = START;
            else 
                next_state = IDLE;

        START:                                        // STATE 1
            next_state = ITERATE;
            
        ITERATE:                                    // STATE 2
            if (count = 3)
                next_state = STOP;
            else 
                next_state = FORLOOPWAIT;        

        STOP:                                    // STATE 3          
                                   
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
        start <= 1'b0;
    end
    else begin 
        case(state)
        IDLE: 
            begin

            end              
        START: 
            begin
               
            end
        ITERATE: 
            begin

            end
        STOP: 
            begin

            end
       endcase
    end
    end
    
    
    // datapath
    always @(posedge clk)
    begin : DATAPATH
        if (resetn==1'b0) begin         
            c <= 0;              
            reg_result <= {516{1'b0}};
            count <= 3'b000;
            keep_result <= 1'b0;     
        end
        else begin
            case(state)
                IDLE:
                begin
                    c <= {(n+2){1'b0}};
                    count <= 2'b00;
                    a <= in_a;
                    b <= in_b;
                    m <= in_m;
                end
                FORLOOP:
                begin 
                    if (a[i] == 1'b1)
                        in_b_a <= in_b_a_wire;
                    else 
                        in_b_a <= {514{1'b0}};
                    i <= i + 1;
                end
                FORLOOPWAIT:
                begin
                    c <= result_a;
                    in_b_a <= in_b_a_wire;
                end
                INLOOPSHIFT:
                begin
                    c <= c >> 1;
                    in_b_a <= in_b_a_wire;
                end
                INLOOPADDSHIFT:
                begin
                    in_b_a <= in_b_a_wire;
                end
                INLOOPADDSHIFTWAIT:
                begin
                    c <= result_a;
                end
                MODULOCHECK:
                begin
                    in_b_a <= in_b_a_wire;
                    reg_result <= result_a[513:0];
                end
                MODULOCHECKWAIT:
                begin
                    // c <= result_a[514] ? result_a[513:0] : c;
                    
                end
                CHOOSERESULT:
                begin 
                    c <= result_a[514] ? result_a[513:0] : c;
                end
                STOP:
                begin
                    
                end
            
            endcase    
        end
    end
        
    assign result = c[511:0];    
        
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





    
    
    
    always @(posedge clk)
    begin
    if (resetn==1'b0) begin     // a <= 0;
        c <= 0;                 // b <= 0;
        reg_result <= {516{1'b0}};
        count <= 3'b000;
        keep_result <= 1'b0;     
    end
    else if (start==1'd1) begin     // a <= in_a[nb_bits-1:0];
        c <= subtract;              // b <= (~)in_b[nb_bits-1:0];
        reg_result <= {516{1'b0}};
        count <= 3'b001;   
        keep_result <= 1'b0;     
    end
    else if (start == 1'b0 && done != 1'b1) begin   // different inputs are selected for a and b
        reg_result <= resultwire;
        //reg_result <= res_shift;
        c <= add_out[nb_bits];
        if (count == 3'b011) begin
            keep_result <= 1'b1;
            end
        count <= count+1;
    end
    else if (start == 1'b0 && done == 1'b1) begin   // a <= 0;
        count <= 0;                                 // b <= 0;
    end
    else begin                                      // a <= 0;
        c <= 0;                                     // b <= 0;
        count <= 0;
        reg_result <= 0;
    end
    end 
    
//    always @(posedge clk)
//    begin
//    if (shift==1'b1) begin
//    reg_result <= reg_result >> 1;
//    end
//    end
    
    always @(posedge clk)
    begin
        if (resetn==1'b0) begin                             // c <= 0;
            a <= 0;                                         // reg_result <= 0;
            b <= 0;                                         // count <= 3'b000;
        end
        else if (start==1'd1 && subtract == 1'b0) begin     // c <= 0;
            a <= in_a[nb_bits-1:0];                         // reg_result <= 0;
            b <= in_b[nb_bits-1:0];                         // count <= 3'b001;
            in_a_reg <= in_a;
            in_b_reg <= in_b;
        end
        else if (start==1'd1 && subtract == 1'b1) begin     // c <= 1;
            a <= in_a[nb_bits-1:0];                         // reg_result <= 0;
            b <= ~in_b[nb_bits-1:0];                        // count <= 3'b001;
            in_a_reg <= in_a;
            in_b_reg <= in_b;
        end
        else if (start == 1'b0 && done != 1'b1) begin       // reg_result <= resultwire;
                                                            // c <= add_out[nb_bits];      
                                                            // count <= count+1;          
            if (count == 3'b001) begin
                a <= in_a_reg[(2*nb_bits)-1:nb_bits];
//                if (subtract == 1'b0) b <= in_b_reg[(2*nb_bits)-1:nb_bits];
//                else b <= ~in_b_reg[(2*nb_bits)-1:nb_bits];
                if (subtract == 1'b0) b <= in_b[(2*nb_bits)-1:nb_bits];
                else b <= ~in_b[(2*nb_bits)-1:nb_bits];
            end
            else if (count == 3'b010) begin
                a <= in_a_reg[(3*nb_bits)-3:2*nb_bits];
//                if (subtract == 1'b0) b <= in_b_reg[(3*nb_bits)-3:2*nb_bits];
//                else b <= ~in_b_reg[(3*nb_bits)-3:2*nb_bits];
                if (subtract == 1'b0) b <= in_b[(3*nb_bits)-3:2*nb_bits];
                else b <= ~in_b[(3*nb_bits)-3:2*nb_bits];
            end
        end
        //else if (start == 1'b0 && done == 1'b1) begin
            //a <= 0;
            //b <= 0;
            //c <= c;
            //reg_result <= loop;
            //count <= 0;
        //end
        /*else begin
            //a <= 0;
            //b <= 0;
        end*/
    end 

endmodule