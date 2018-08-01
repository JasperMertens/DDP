
`timescale 1ns / 1ps

/*
Assignment:
1. Use this testbench (tb) to verify the correctness of your adder
    You can start the simulation by pressing the buttons on the left-hand: Simulation | Run Simulation
2. Implement a multi-precision adder in adder.v
3. Update the design with a two's-compliment subtractor (activate it with the 'subtract' wire)
3. Make an implementation of your design (Implementation | Run Implementation).
4. Determine the maximum clock frequency of the design (Efficient designs have a clock of around 100MHz)
5. Calculate the total execution time of one add operation
*/

`timescale 1ns / 1ps

`define RESET_TIME 25
`define CLK_PERIOD 10
`define CLK_HALF 5

module tb_adder();

    // Define internal regs and wires
    reg          clk;
    reg          resetn;
    reg  [513:0] in_a;
    reg  [513:0] in_b;
    reg          start;
    reg          subtract;
    reg          shift;
    reg          result_ok;
    wire [514:0] result;
    wire         done;

    reg  [514:0] expected;

    // Instantiating adder
    adder dut (
        .clk      (clk     ),
        .resetn   (resetn  ),
        .start    (start   ),
        .subtract (subtract),
        .shift    (shift   ),
        .in_a     (in_a    ),
        .in_b     (in_b    ),
        .result   (result  ),
        .done     (done    ));

    // Generate Clock
    initial begin
        clk = 0;
        forever #`CLK_HALF clk = ~clk;
    end

    // Initialize signals to zero
    initial begin
        in_a     <= 0;
        in_b     <= 0;
        subtract <= 0;
        shift    <= 0;
        start    <= 0;
    end

    // Reset the circuit
    initial begin
        resetn = 0;
        #`RESET_TIME
        resetn = 1;
    end

    task perform_add;
        input [513:0] a;
        input [513:0] b;
        begin
            in_a <= a;
            in_b <= b;
            start <= 1'd1;
            subtract <= 1'd0;
            #`CLK_PERIOD;
            start <= 1'd0;
            wait (done==1);
            #`CLK_PERIOD;
        end
    endtask

    task perform_sub;
        input [513:0] a;
        input [513:0] b;
        begin
            in_a <= a;
            in_b <= b;
            start <= 1'd1;
            subtract <= 1'd1;
            #`CLK_PERIOD;
            start <= 1'd0;
            wait (done==1);
            #`CLK_PERIOD;
        end
    endtask

    initial begin

    #`RESET_TIME

    /*************TEST ADDITION*************/
    
    $display("\nAddition with testvector 1");
    
    // Check if 1+1=2
    #`CLK_PERIOD;
    perform_add(514'h1, 
                514'h1);
    expected  = 515'h2;
    wait (done==1);
    
    result_ok = (result==expected);
    
    #`CLK_PERIOD;     
    $display("result calculated=%x", result);
    $display("result expected  =%x", expected);
    $display("error            =%x", expected-result);
    
    
    $display("\nAddition with testvector 2");

    // Test addition with large test vectors. 
    // You can generate your own vectors with testvector generator python script.
    perform_add(514'h26cabac64f8573fc11798243176c861695c2e41c76022b91b1bcf50c0e5fe57945bba72cc65bec65fdb51b08218e98a93be857e4e6deb90b2841e3ac65bc72386,
                514'h2a34bae83b7fa781f7ecde7753f30cbc6df7d94c0ba8c0f29168fcd5fcb4e4534e722e0e2c17a57987f160d456c324f6c6b462fec4968aa8b01812c506425a16a);
    expected  = 515'h50ff75ae8b051b7e096660ba6b5f92d303babd6881aaec844325f1e20b14c9cc942dd53af27391df85a67bdc7851bda0029cbae3ab7543b3d859f6716bfecc4f0;
    wait (done==1);
    
    result_ok = (result==expected);

    #`CLK_PERIOD;     
    $display("result calculated=%x", result);
    $display("result expected  =%x", expected);
    $display("error            =%x", expected-result);
    
    // Test shifting as well
    #`CLK_PERIOD;    
    shift <= 1'b1;
    #`CLK_PERIOD; 
    shift <= 1'b0;
    expected  = 515'h287fbad745828dbf04b3305d35afc96981dd5eb440d576422192f8f1058a64e64a16ea9d7939c8efc2d33dee3c28ded0014e5d71d5baa1d9ec2cfb38b5ff66278;
    
    result_ok = (result==expected);
    
    $display("result shifted   =%x", result);
    $display("result expected  =%x", expected);
    $display("error            =%x", expected-result);
    #`CLK_PERIOD; 
    
    /*************TEST SUBTRACTION*************/

    $display("\nSubtraction with testvector 1");
    
    // Check if 1-1=0
    #`CLK_PERIOD;
    perform_sub(514'h1, 
                514'h1);
    expected  = 515'h0;
    wait (done==1);
    
    result_ok = (result==expected);

    #`CLK_PERIOD;    
    $display("result calculated=%x", result);
    $display("result expected  =%x", expected);
    $display("error            =%x", expected-result);


    $display("\nSubtraction with testvector 2");

    // Test subtraction with large test vectors. 
    // You can generate your own vectors with testvector generator python script.
    perform_sub(514'h3f12eadac849c11b2eb390a6b1bcf40c50b17adfad30c0a4eb67edbff025236192bdf0812cb0c55e0a8438b92832b3a4c0dd2cb402cc03e904ac73b5c8b63c139,
                514'h3f6837b7c0df55b0bcf48bdb6d38065def3cc5a9eb6815c478763ad5e4586d589c67cd2831b47bec5ae6ff7f6c4f0556435258da313acd48b125bef74ef276754);
    expected  = 515'h7faab323076a6b6a71bf04cb4484edae6174b535c1c8aae072f1b2ea0bccb608f6562358fafc4971af9d3939bbe3ae4e7d8ad3d9d19136a05386b4be79c3c59e5;
    wait (done==1);
    
    result_ok = (result==expected);
    
    #`CLK_PERIOD;    
    $display("result calculated=%x", result);
    $display("result expected  =%x", expected);
    $display("error            =%x", expected-result);
    
    // Test shifting as well
    #`CLK_PERIOD;    
    shift <= 1'b1;
    #`CLK_PERIOD; 
    shift <= 1'b0;
    $display("result shifted   =%x", result);
    #`CLK_PERIOD; 
    
    $display("\n");
    
    #`CLK_PERIOD;     








    $display("\nAddition with EXTRA testvector");

    // Test addition with large test vectors. 
    // You can generate your own vectors with testvector generator python script.
    perform_add(514'h3dd1031da71b40500e7b344a99ff8ac2dccd650360dcc2797dc8bcb9552ecec2523fe6828101f718889b7ae1c164cd3bbec4242ae7f58639f7d2e7ca7b0f532ba,
                514'h22432a50c915543b67564a53418ce46be732b4de0db6c493f0588167a5645f48236d446b34d9641c76c6fbf3156e0bbdf9ae422932e60bb7e2de2e6a51c03f3f9);
    expected  = 515'h60142d6e7030948b75d17e9ddb8c6f2ec40019e16e93870d6e213e20fa932e0a75ad2aedb5db5b34ff6276d4d6d2d8f9b87266541adb91f1dab11634cccf926b3;
    wait (done==1);
    
    result_ok = (result==expected);

    #`CLK_PERIOD;     
    $display("result calculated=%x", result);
    $display("result expected  =%x", expected);
    $display("error            =%x", expected-result);
    
    // Test shifting as well
    #`CLK_PERIOD;    
    shift <= 1'b1;
    #`CLK_PERIOD; 
    shift <= 1'b0;
    $display("result shifted   =%x", result);
    #`CLK_PERIOD; 
    
    $display("\n");
    #`CLK_PERIOD;     
    
    
    
    
    
    $display("\nSUBSTRACTION with MONT RESULT testvector");

    // Test addition with large test vectors. 
    // You can generate your own vectors with testvector generator python script.
    perform_sub(514'h0abae4fe60ecfcb7115d9d334a1b365438b7abde4b5a0bf1193e83c27bf7baa287464360a92f22ec0625005fcafeeed3bc7977f0b7c0fa8897387e484674e29e7,
                514'h0a0f7d22d90093ce8e7210c4f7a48ba439dba03d40ddc9761161320ce9ff15cdacb07b47b2ef935433c3974fd93334b492eaf4f8a866f037933a18f810f26146f);
    expected  = 515'h00ab67db87ec68e882eb8c6e5276aaaffedc0ba10a7c427b07dd51b591f8a4d4da95c818f63f8f97d261690ff1cbba1f298e82f80f5a0a5103fe6550358281578;
    wait (done==1);
    
    result_ok = (result==expected);

    #`CLK_PERIOD;     
    $display("result calculated=%x", result);
    $display("result expected  =%x", expected);
    $display("error            =%x", expected-result);
    
    // Test shifting as well
    #`CLK_PERIOD;    
    shift <= 1'b1;
    #`CLK_PERIOD; 
    shift <= 1'b0;
    $display("result shifted   =%x", result);
    #`CLK_PERIOD; 
    
    $display("\n");
    #`CLK_PERIOD; 


    $finish;

    end

endmodule
