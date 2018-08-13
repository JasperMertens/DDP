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
    
    wire [513:0] in_b_new;
    //assign in_b_new = subtract ? ~in_b : in_b;
    assign in_b_new = in_b;
       
    parameter n = 103;
    
    wire [n-1:0] A0  = in_a[n-1:0];
    wire [n-1:0] A1  = in_a[2*n-1:n];
    wire [n-1:0] A2  = in_a[3*n-1:2*n];
    wire [n-1:0] A3  = in_a[4*n-1:3*n];
    wire [n-1:0] A4 =  {1'b0, in_a[5*n-2:4*n]};

    wire [n-1:0] B0 = in_b_new[n-1:0];
    wire [n-1:0] B1 = in_b_new[2*n-1:n];
    wire [n-1:0] B2 = in_b_new[3*n-1:2*n];
    wire [n-1:0] B3 = in_b_new[4*n-1:3*n];
    wire [n-1:0] B4 = {1'b0, in_b_new[5*n-2:4*n]};
    
    
    wire [n-1:0] S0, S1, S2, S3;
    wire [n-2:0] S4;
    wire C1, C2, C3, C4, C5;
    
    wire [514:0] resultwire;
    reg [514:0] result_reg;
        
    carryselect     X0(A0, B0, subtract, S0, C1);
    //assign {C1, S0} = A0 + B0 + subtract;
    carryselect     X1( A1,  B1,  C1,  S1,  C2);
    carryselect     X2( A2,  B2,  C2,  S2,  C3);
    carryselect     X3( A3,  B3,  C3,  S3,  C4);
    carryselectlast X4( A4,  B4,  C4,  S4,  C5);   
       
    assign resultwire = shift ? {1'b0, (C5^subtract), S4, S3, S2, S1, S0[n-1:1]} : {(C5^subtract), S4, S3, S2, S1, S0};
    assign result = result_reg;       
     
    reg done_reg;
    assign done = done_reg;
        
    always @(posedge clk)
    begin : OUTPUT_LOGIC
        if (start == 1'b1)
            done_reg <= 1'b1;
        else  
            done_reg = 1'b0;        
    end
    
    always @(posedge clk)
    begin : DATAPATH
        if (resetn==1'b0) 
            result_reg <= {(514){1'b0}};
        else begin
            if (start == 1'b1) result_reg <= resultwire;
            else result_reg <= result_reg;
        end
    end
endmodule

module carryselect(
    input  wire [102:0] a,
    input  wire [102:0] b,
    input  wire        c_in,
    output wire [102:0] s,
    output wire        c_out);
    
    wire [103:0] sumcarry0, sumcarry1;
    
    assign sumcarry0 = a + b;
    assign sumcarry1 = a + b + 1'b1;
    
    assign s     = c_in ? sumcarry1[102:0] : sumcarry0[102:0];
    assign c_out = c_in ? sumcarry1[103]   : sumcarry0[103];
    
endmodule

module carryselectlast(
    input  wire [101:0] a,
    input  wire [101:0] b,
    input  wire        c_in,
    output wire [101:0] s,
    output wire        c_out);
    
    wire [102:0] sumcarry0, sumcarry1;
    
    assign sumcarry0 = a + b;
    assign sumcarry1 = a + b + 1'b1;
    
    assign s     = c_in ? sumcarry1[101:0] : sumcarry0[101:0];
    assign c_out = c_in ? sumcarry1[102]   : sumcarry0[102];
    
endmodule  
    