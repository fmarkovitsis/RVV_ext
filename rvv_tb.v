`timescale 10ns/10ns

module rvv_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [3:0] valu_op;
    reg [2:0] sew_encoded_id;
    reg [2:0] lmul_encoded_id;
    reg [7:0] AVL;
    reg [4:0] raA, raB, wa;
    reg [63:0] wd;
    reg [31:0] alu_scalar_in_id;
    reg wen;

    // Outputs
    wire [63:0] alu_res;

    // Instantiate the Unit Under Test (UUT)
    RVV uut (
        .clk(clk),
        .rst(rst),
        .valu_op(valu_op),
        .sew_encoded_id(sew_encoded_id),
        .lmul_encoded_id(lmul_encoded_id),
        .AVL(AVL),
        .raA(raA),
        .raB(raB),
        .wa(wa),
        .wd(wd),
        .alu_scalar_in_id(alu_scalar_in_id),
        .wen(wen),
        .alu_res(alu_res)
    );

    // Clock generator
    always #1 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        valu_op = 4'b0000; // addition
        sew_encoded_id = 3'b001; // example SEW = 8-bit
        lmul_encoded_id = 3'b000; // example LMUL = 1
        AVL = 8'd16;
        raA = 0; 
        raB = 0; 
        wa = 0;
        wd = 0;
        alu_scalar_in_id = 32'h0;
        wen = 0;

        #20 rst = 1;

// elementwise addition
// sew 8 
// lmul 1 (no grouping)
// h00_FF_00_FF_00_FF_00_FF + hFF_00_FF_00_FF_00_FF_00 = hFF_FF_FF_FF_FF_FF_FF_FF
        #20;
        // Write at reg 2
        wa = 5'd2;
        wd = 64'h00_FF_00_FF_00_FF_00_FF;
        wen = 1;
        #10;
        wen = 0;
        #10;

        // Write at reg 3
        wa = 5'd3;
        wd = 64'hFF_00_FF_00_FF_00_FF_00;
        wen = 1;
        #10;
        wen = 0;
        #10;

        // Read from reg 2 and reg 3
        raA = 5'd2;
        raB = 5'd3;
        #10;

        #50;
        $display("ALU result = %h", alu_res);        

// elementwise addition
// sew 8 
// lmul 1 (no grouping)
// h00_FF_00_FF_00_FF_00_FF + h00_01_00_01_00_01_00_01 = h00_00_00_00_00_00_00_00
        #20;
        // Write at reg 3
        wa = 5'd3;
        wd = 64'h00_01_00_01_00_01_00_01;
        wen = 1;
        #10;
        wen = 0;
        #10;

        #50;
        $display("ALU result = %h", alu_res);

// elementwise addition
// sew 16 
// lmul 1 (no grouping)
// h00_FF_00_FF_00_FF_00_0F + h00_01_00_01_00_01_00_01 = h01_00_01_00_01_00_01_00  
       #20;
       sew_encoded_id = 3'b010; // SEW = 16-bit
        
       #50;
       $display("ALU result = %h", alu_res);



        
// Apply reset
        rst = 0;
        raA = 0; 
        raB = 0; 
        wa = 0;
        wd = 0;
        wen = 0;
        #50
        alu_scalar_in_id = 32'h1;
        valu_op = 4'b0001; // vector + scalar addition
        sew_encoded_id = 3'b001; // SEW = 8-bit
        lmul_encoded_id = 3'b000; // LMUL = 1
        AVL = 8'd16;
        #20 rst = 1;




// vector + scalar addition
// sew 8 
// lmul 1 (no grouping)
// h00_FF_00_FF_00_FF_00_FF + 1 = h01_00_01_00_01_00_01_00
        #20;
        // Write at reg 2
        wa = 5'd2;
        wd = 64'h00_FF_00_FF_00_FF_00_FF;
        wen = 1;
        #10;
        wen = 0;
        #10;

        // Read from reg 2 and reg 3
        raA = 5'd2;
        raB = 5'd3;
        #10;

        #50;
        $display("ALU result = %h", alu_res);        

// vector + scalar addition
// sew 16 
// lmul 1 (no grouping)
// h00_FF_00_FF_00_FF_00_FF + 1 = h01_00_01_00_01_00_01_00  
       #20;
       sew_encoded_id = 3'b010; // SEW = 16-bit

       #50;
       $display("ALU result = %h", alu_res);



        
// Apply reset
        rst = 0;
        raA = 0; 
        raB = 0; 
        wa = 0;
        wd = 0;
        wen = 0;
        #50
        alu_scalar_in_id = 32'h0;
        valu_op = 4'b0010; // elementwise subtraction
        sew_encoded_id = 3'b001; // SEW = 8-bit
        lmul_encoded_id = 3'b000; // LMUL = 1
        AVL = 8'd16;
        #20 rst = 1;



        
// elementwise subtraction
// sew 8 
// lmul 1 (no grouping)
// h00_02_00_02_00_02_00_02 - h00_01_00_01_00_01_00_01 = h00_01_00_01_00_01_00_01
        #20;        
        // Write at reg 2
        wa = 5'd2;
        wd = 64'h00_02_00_02_00_02_00_02;
        wen = 1;
        #10;
        wen = 0;
        #10;

        // Write at reg 3
        wa = 5'd3;
        wd = 64'h00_01_00_01_00_01_00_01;
        wen = 1;
        #10;
        wen = 0;
        #10;

        // Read from reg 2 and reg 3
        raA = 5'd2;
        raB = 5'd3;
        #10;

        #50;
        $display("ALU result = %h", alu_res);        

// elementwise subtraction
// sew 8 
// lmul 1 (no grouping)
// h00_02_00_02_00_02_00_02 - h00_03_00_03_00_03_00_03 = h00_FF_00_FF_00_FF_00_FF
        #20;
        // Write at reg 3
        wa = 5'd3;
        wd = 64'h00_03_00_03_00_03_00_03;
        wen = 1;
        #10;
        wen = 0;
        #10;

        #50;
        $display("ALU result = %h", alu_res);

// elementwise subtraction
// sew 16 
// lmul 1 (no grouping)
// h00_02_00_02_00_02_00_02 - h00_03_00_03_00_03_00_03 = h01_00_01_00_01_00_01_00  
       #20;
       sew_encoded_id = 3'b010; // SEW = 16-bit

       #50;
       $display("ALU result = %h", alu_res);




        // Apply reset
        rst = 0;
        raA = 0; 
        raB = 0; 
        wa = 0;
        wd = 0;
        wen = 0;
        alu_scalar_in_id = 32'h0;
        valu_op = 4'b0011; // vector - scalar subtraction
        sew_encoded_id = 3'b001; // SEW = 8-bit
        lmul_encoded_id = 3'b000; // LMUL = 1
        AVL = 8'd16;
        #20 rst = 1;




// vector - scalar subtraction
// sew 8 
// lmul 1 (no grouping)
// h00_FF_00_FF_00_FF_00_FF - 1 = hFF_FE_FF_FE_FF_FE_FF_FE
        #20;
        // Write at reg 2
        wa = 5'd2;
        wd = 64'h00_FF_00_FF_00_FF_00_FF;
        wen = 1;
        #10;
        wen = 0;
        #10;

        // Read from reg 2 and reg 3
        raA = 5'd2;
        raB = 5'd3;
        #10;

        #50;
        $display("ALU result = %h", alu_res);        

// vector - scalar subtraction
// sew 16 
// lmul 1 (no grouping)
// h00_FF_00_FF_00_FF_00_FF - 1 = h00_FE_00_FE_00_FE_00_FE  
       #20;
       sew_encoded_id = 3'b010; // SEW = 16-bit

       #50;
       $display("ALU result = %h", alu_res);



        
// Apply reset
        rst = 0;
        raA = 0; 
        raB = 0; 
        wa = 0;
        wd = 0;
        wen = 0;
        #50
        alu_scalar_in_id = 32'h0;
        valu_op = 4'b0010; // subtraction
        sew_encoded_id = 3'b001; // SEW = 8-bit
        lmul_encoded_id = 3'b000; // LMUL = 1
        AVL = 8'd16;
        #20 rst = 1;        
        
        // Finish simulation
        #50;
        $finish;
    end

endmodule
