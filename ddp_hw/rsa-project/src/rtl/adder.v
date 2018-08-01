`timescale 1ns / 1ps

module adder(
    input  wire         clk,
    input  wire         resetn,
    input  wire         start,
    input  wire         subtract,
    input  wire [512:0] in_a,
    input  wire [512:0] in_b,    
    output wire [513:0] result,
    output wire         done    
    );
    
    //-------------Internal Constants--------------------------
    parameter SIZE = 171            ; // Size of the adder
    parameter STATES = 3            ; // Number of states
    parameter IDLE  = 3'b001,CALC = 3'b010,SHIFT = 3'b100 ;

    reg [512:0] a,b;
    reg [513:0] reg_result;
    reg [2:0]   counter;
	
    // What impact does a 513-bit add operation have on the critical path of the design? 
    wire c;
	assign c = (subtract) ^ reg_result[513-SIZE];
    wire [SIZE:0] add_out;
    assign add_out = a[SIZE-1:0] + b[SIZE-1:0] + c; // combine add_out and sub_out for optimisation
    wire [SIZE:0] sub_out;
    assign sub_out = a[SIZE-1:0] + ~b[SIZE-1:0] + c;
    wire stop_add;
    assign stop_add = counter[0];
   
	
	
	//-------------Internal Variables---------------------------
	reg   [STATES-1:0]          state        ;// Seq part of the FSM
	reg   [STATES-1:0]          next_state   ;// combo part of FSM
				
		
	// FSM next state combo logic
	always @(state or start or stop_add)
	begin : FSM_COMBO
		next_state = 3'b000;
		case(state)
		IDLE: 	
				if (start==1'b1) begin
					   next_state = CALC;
				end else begin
					next_state = IDLE;
				end
		CALC:
				if (stop_add==1'b1) begin // calculation is finished
					next_state 	= IDLE;
				end else begin
					next_state	= SHIFT;
				end
		SHIFT:
				next_state	= CALC;
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
		counter <= 3'b100;
	end
	else begin 
        case(state)
        IDLE: begin
              counter <= 3'b100;
              end              
        CALC: begin
                if (stop_add==1'b1) begin // calculation is finished
                    counter <= 3'b100;;
                end
                end
        SHIFT: begin
               counter <= counter >> 1;
               end
       endcase
	end
	end

    always @(posedge clk)
    begin : DATAPATH
        if (resetn==1'b0) begin
            a <= {513{1'b0}};
            b <= {513{1'b0}};
            reg_result <= {514{1'b0}};
        end
		else begin
			case(state)
				IDLE : begin
					if (start==1'b1) begin
						a <= in_a[512:0];
						b <= in_b[512:0];
						reg_result <= {514{1'b0}};
					end else begin
					a <= {513{1'b0}};
                    b <= {513{1'b0}};
                    end
				end
				CALC : begin
				    if (subtract) begin
                        reg_result[513:513-SIZE] <= sub_out;
                    end else begin
					reg_result[513:513-SIZE] <= add_out;   //store result in the leftmost SIZE+1 bits
					end
					end
				SHIFT : begin
					a <= a >> SIZE;
                    b <= b >> SIZE;
                    reg_result = reg_result >> SIZE;
	               end
                default : begin
                    a <= {513{1'b0}};
                    b <= {513{1'b0}};
                    reg_result <= {514{1'b0}};
                end
			endcase;
        end
    end
	
	/*assign done = state[0] ^ start;*/
	assign done = counter[0];
    assign result = reg_result[513:0];
    
endmodule