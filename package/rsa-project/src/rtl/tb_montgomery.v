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
    reg          result_ok;
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


    // Assistants testvector (no modulo operation needed)

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
        
        result_ok = (result==expected);
        
        $display("\n Original testvector, no modulo operation");
        $display("result calculated =%x", result);
        $display("result expected   =%x", expected);
        $display("error             =%x", expected-result);
        
        #`CLK_PERIOD;
          
    // TESTVECTOR 1 (NO MODULO OPERATION) OUDE PYTHON TESTFILE ASSISTENTEN  
                
        result_ok = 0;
                
        #`RESET_TIME
        
        in_a     <= 512'ha84ff2f71071936d568335f4e31da1c104c831dc18d7b9199f5d96b9df7315bd0fa8db7a6201cf9ae0842c7f6797a025684296de2089f536c18b7a583c7a9fc5;
        in_b     <= 512'hb9cf554dbc2f7d876274c0895b10c21a0322d9435a2cd1af43a483a61f7cfb92f984df1a0d9357bc796f8e582427a609d99348f8079de7731fc8a31b3eea6c6e;
        in_m     <= 512'hef449a8c29c1266af559bdb8d0c42c042b9a46f619b28d7094369f2842ebe42175eb00442338301d1a509aef69043c1dee3bc1f3a06da74e54d094bc7e4ec49b;
        expected <= 512'h989c4842b4d4e09c463ce7eb282963433113fc4f59dd86fc94ae85db3a992a9da4d38f4aaf9c263810e38ba8969c21e32857163a64deb38db64bb0c957fd0578;
        
        start<=1;
        #`CLK_PERIOD;
        start<=0;
        
        wait (done==1);
        
        result_ok = (result==expected);
        
        $display("\n Testvector 1 old script, no modulo operation");
        $display("result calculated =%x", result);
        $display("result expected   =%x", expected);
        $display("error             =%x", expected-result);
        
        #`CLK_PERIOD;
        
    // TESTVECTOR 2 (MODULO OPERATION!!) OUDE PYTHON TESTFILE ASSISTENTEN  
                    
        result_ok = 0;
                
        #`RESET_TIME
        
        in_a     <= 512'hf93e63a31fa57a5fe8e2ecd7cc9657037c1a5e007bcf23e5a60cd041f0ee66f7059efec3ece49feb3dab4bb1ad331ac6fd2c85dd29ea996c94a391033e673a62;
        in_b     <= 512'habee6fa6ade416c6cf101ccf6926cc8a1d10afbc02d219bcda52ceeaedf880b3e8516ff259d339d051bb54df25a5385e47b05cb4686b4f3231e260b25b024fd9;
        in_m     <= 512'ha0f7d22d90093ce8e7210c4f7a48ba439dba03d40ddc9761161320ce9ff15cdacb07b47b2ef935433c3974fd93334b492eaf4f8a866f037933a18f810f26146f;
        expected <= 512'h0ab67db87ec68e882eb8c6e5276aaaffedc0ba10a7c427b07dd51b591f8a4d4da95c818f63f8f97d261690ff1cbba1f298e82f80f5a0a5103fe6550358281578;
        
        start<=1;
        #`CLK_PERIOD;
        start<=0;
        
        wait (done==1);
        
        result_ok = (result==expected);

        $display("\n Testvector 2 old script with modulo operation");
        $display("result calculated =%x", result);
        $display("result expected   =%x", expected);
        $display("error             =%x", expected-result);
        
        #`CLK_PERIOD;
    
    // TESTVECTOR 3 (MODULO OPERATION!!) OUDE PYTHON TESTFILE ASSISTENTEN   
                    
        result_ok = 0;
                
        #`RESET_TIME
        
        in_a     <= 512'hc1e7a24fb38065dc02d0169985890870a3dada3d1c1a11f596cdf00309443f6425b7c296011651297587066629142e1d18f9caca158876fa78d999bcd3d975f5;
        in_b     <= 512'hc28c67b947fbda048b61f4a7a8b898a1ec2262323bac7ccbdd4a2945e1278d08603b7ad11fe735d2d4f20dab63706bb69ddc095340a1deedb585983feff60cb8;
        in_m     <= 512'h85043c00a323657b8b1b421888721ddda6fee5b443f4e3920ec0e8d961496ee7c1a6e0edbf97c8186ab20403110d58e3fc32af1f7ef8b302d75bc796ec62a577;
        expected <= 512'h0d2c7a007de6e0bcd84baa0c8614cb8168afa2004dc70c2e33b76c7b7f2aa091bdaa6004c70e5f40a63f74c43a5ddc95ecb7ac30de4742c452f8135cbb2a7955;
        
    // HIERMEE GEBEURT IETS VIES RAAR... OP HET EINDE MOET DE M VECTOR 2 KEER VAN C AFETROKKEN WORDEN IPV 1 KEER??? NAVRAGEN BIJ ASSISTENTEN!!
        
        start<=1;
        #`CLK_PERIOD;
        start<=0;
        
        wait (done==1);
        
        result_ok = (result==expected);
        
        $display("\n Testvector 3 old script with modulo operation, fishy result");
        $display("result calculated       =%x", result);
        $display("result expected         =%x", expected);
        $display("error                   =%x", expected-result);
        $display("result calculated - m   =%x", result-in_m);
        $display("result expected         =%x", expected);
        $display("error                   =%x", expected-result+in_m);

        #`CLK_PERIOD;
        
        
        
        //----------//   NIEUWE PYTHON TESTFILE   //----------//

        // TESTVECTOR 1 (NO MODULO OPERATION!!)    

        result_ok = 0;
                        
        #`RESET_TIME
        
        in_a     <= 512'h916ade34be3f936a094b0ddf56f4b185e8f107fa68c0e00688ce700d32214447b1d611fc6d3d00b1a61c05e53ececbe9f5ea00e6c5ef4e30f00adb6b26066cb7;
        in_b     <= 512'heeb46eefe6202808d27b0f6f1b3189c09c5918328f5b152ef3f1e219dc2796c81424e60f2533abfdc048423d4873900c9a9bf7fb83e465d3aee5d43662dd80a2;
        in_m     <= 512'hf7f0281e603d4f0822786a1ad1962f1078d0c9329961453a8e4c8d792aad933ec91acbb61b3521a73741f11850ef37ffc077c20123d560b47a3e3c47844b11f3;
        expected <= 512'he40e9abd5ae86562dc91dc76d9db38e5bb7fefa51693f93f7d9cf5225f16a1d4fcba14682763a76daf72ae1251f7f244039912aee4e7dd67e44ae46274965540;
        
        start<=1;
        #`CLK_PERIOD;
        start<=0;
        
        wait (done==1);
        
        result_ok = (result==expected);

        $display("\n Testvector 1 new script without modulo operation");
        $display("result calculated =%x", result);
        $display("result expected   =%x", expected);
        $display("error             =%x", expected-result);
        
        #`CLK_PERIOD;
        
        // TESTVECTOR 2 (NO MODULO OPERATION!!)    
                    
        result_ok = 0;
                
        #`RESET_TIME
        
        in_a     <= 512'ha84a70620bce614acf88961ff689d9a24e8efdbe7807b0020b486cfa6f3de3a6968069d821ae92023ccc3b6926ac87a5e5a1118e4ffd5aa297332b5f3fe555fb;
        in_b     <= 512'hf24e23e39761cab23c31df7b03ac28ce65e42fbcd6b81b8696b4a0a5f9b63fdc1de86094185125d808312595aaaad8aca74912b39567a26383f3875c3c41cbf5;
        in_m     <= 512'hffbb6bf34452a189ed39b8f42f68af3a9c58569f5912a646aa696c08bc06f610e24ae24807410b0c81d288550799e04c0a4603853027d1733f60c8329a22c87f;
        expected <= 512'h6c14285ea125ff316712e423226ac84fef1f76c001bfa558326a42a8b7555a31bdbc0e3561373b022b848271ccc06026461a8b569c63e8cb69f111c14265afed;
        
        start<=1;
        #`CLK_PERIOD;
        start<=0;
        
        wait (done==1);
        
        result_ok = (result==expected);

        $display("\n Testvector 2 new script with modulo operation");
        $display("result calculated =%x", result);
        $display("result expected   =%x", expected);
        $display("error             =%x", expected-result);
        
        #`CLK_PERIOD;

        // TESTVECTOR 3 (MODULO OPERATION!!)    
                    
        result_ok = 0;
                
        #`RESET_TIME
        
        in_a     <= 512'ha9ce8e7093495c6a0902970dc61842be6e22e8557cca51a73e0195fc35922394987149b7618981d0022e123b09bcd6c46a215053f1c42923fa8fe6fab7b6bb07;
        in_b     <= 512'hc137473a7b42dff91123400a6b0a58a95a4e6a63433cc07ea911f597ce2c15f96e5d50c1fb10a13a883453c9290803dd1b76fabbeab05d2820ab0908d357c42b;
        in_m     <= 512'h8ed8d86eb342145bd7fb4b773d4661e2e0b4f37ab52cb4dd329b40da7248e38c1491565c2577eb8b66819b4e36a59856087b086a0bc8fd4cfe85ab045c32c0c5;
        expected <= 512'h27491996f90ebcb4a11bc29ed6578d17d4d9f642e61a994476813191c63aa4a47b5d4873555bbbe35ce46dd0ae4a2c656abaa6005d6e2469ac59d608a820806c;
        
        start<=1;
        #`CLK_PERIOD;
        start<=0;
        
        wait (done==1);
        
        result_ok = (result==expected);

        $display("\n Testvector 3 new script with modulo operation");
        $display("result calculated =%x", result);
        $display("result expected   =%x", expected);
        $display("error             =%x", expected-result);
        
        #`CLK_PERIOD;
        
        // TESTVECTOR 4 (MODULO OPERATION!!)    
                    
        result_ok = 0;
                
        #`RESET_TIME
        
        in_a     <= 512'hfdfb53ef1572aa74bb958aac983149f5e5fb708525d80bcc4bb36f2cef7d870d36b663d2204f904876acd11785473296b873da6522de002229a827a01e334123;
        in_b     <= 512'hc0b26561942c63948b0f4efa2d63916ebea859b8446728e008bae98bdf62c95c550480b0917742a45d91f231edb2466cb55e4c6dcc57aa0890c52ccef2851086;
        in_m     <= 512'hc10b8c944a4f59c412cd7919160b1ee067894ecc505224b97d31d077daba6922a6f8e0c359c47a0e904f37bf7cfed135f005fd506285b3c0bc170fc4cf1f240d;
        expected <= 512'h01a3c6ffae1b9f200f6b69839020c1eabd238777e3741aad68332a8ddfd5eebd300252f0c1bd68271e0f89724114733ec26a6961bdbb619e55cefe29752edb01;
        
        start<=1;
        #`CLK_PERIOD;
        start<=0;
        
        wait (done==1);
        
        result_ok = (result==expected);

        $display("\n Testvector 4 new script with modulo operation");
        $display("result calculated =%x", result);
        $display("result expected   =%x", expected);
        $display("error             =%x", expected-result);
        
        #`CLK_PERIOD;
        
        
        $finish;
    end
           
endmodule
