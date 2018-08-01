`timescale 1ns / 1ps
`define RESET_TIME 25
`define CLK_PERIOD 10
`define CLK_HALF 5

module tb_montgomery();
    
    reg          clk;
    reg          resetn;
    reg          start;
    reg  [511:0] in_a;
    reg  [511:0] in_b;
    reg  [511:0] in_m;
    wire [511:0] result;
    wire         done;

    reg  [511:0] expected;
    
    //Instantiating montgomery module
    montgomery montgomery_instance( .clk    (clk    ),
                                    .resetn (resetn ),
                                    .start  (start  ),
                                    .in_a   (in_a   ),
                                    .in_b   (in_b   ),
                                    .in_m   (in_m   ),
                                    .result (result ),
                                    .done   (done   ));

    //Generate a clock
    initial begin
        clk = 0;
        forever #`CLK_HALF clk = ~clk;
    end
    
    //Reset
    initial begin
        resetn = 0;
        #`RESET_TIME resetn = 1;
    end
    
    //Test data
    initial begin

        #`RESET_TIME
        
        // You can generate your own with test vector generator python script
        
        in_a     <= 512'hb4d6d951f6532ac13ec6a44addbb552b3eca8fef9a81a1fd095485063c7ee4f89dcf19acf884fa9d0b6ce9c148e6b85af88024189c1da60e534acc6c7969363b;
        in_b     <= 512'h86eb6f8babc25f0986ba7460e46ffd91f34532c114485075f85ff900d4cf71d918be9ef170e1b84bca67755131efcbb767a2e069ad68c321a1cb985909098399;
        in_m     <= 512'hfe93fee7fd5d369339166e57cf5f773c1698c44b91a9f9a4be462bee6a82552d982845cd2787e90bc0245b4e781b9e1be10c615e2c814b3d85b78e358fa2c393;
        expected <= 512'h949031c785e1767b10ba755667f53317d8d5f1a90f417270509b2b297fbcb536f7e61b05ced28916eba6fedb32920cabbece7750fb6a1a21c943b46b9dad43f9;
        
        start<=1;
        #`CLK_PERIOD;
        start<=0;
        
        wait (done==1);
        
        $display("result calculated=%x", result);
        $display("result expected  =%x", expected);
        $display("error            =%x", expected-result);
        
        #`CLK_PERIOD;
        
        
        
        
        // Toledo testvector
        in_a     <= 512'ha84ff2f71071936d568335f4e31da1c104c831dc18d7b9199f5d96b9df7315bd0fa8db7a6201cf9ae0842c7f6797a025684296de2089f536c18b7a583c7a9fc5;
        in_b     <= 512'hb9cf554dbc2f7d876274c0895b10c21a0322d9435a2cd1af43a483a61f7cfb92f984df1a0d9357bc796f8e582427a609d99348f8079de7731fc8a31b3eea6c6e;
        in_m     <= 512'hef449a8c29c1266af559bdb8d0c42c042b9a46f619b28d7094369f2842ebe42175eb00442338301d1a509aef69043c1dee3bc1f3a06da74e54d094bc7e4ec49b;
        expected <= 512'h989c4842b4d4e09c463ce7eb282963433113fc4f59dd86fc94ae85db3a992a9da4d38f4aaf9c263810e38ba8969c21e32857163a64deb38db64bb0c957fd0578;
        
        start<=1;
        #`CLK_PERIOD;
        start<=0;
        
        wait (done==1);
        
        $display("result calculated=%x", result);
        $display("result expected  =%x", expected);
        $display("error            =%x", expected-result);
        
        #`CLK_PERIOD;
        
        
        
        
        
        
        
        $finish;
    end
           
endmodule
