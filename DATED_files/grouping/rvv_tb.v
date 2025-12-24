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
        lmul_encoded_id = 3'b010; // example LMUL = 4
        AVL = 8'd16;
        raA = 0; 
        raB = 0; 
        wa = 0;
        wd = 0;
        alu_scalar_in_id = 32'h0;
        wen = 0;

        #20 rst = 1;

        // Write to v2 and v3
        wa = 5'd2;
        wd = 64'h01_02_03_04_05_06_07_08; // part 1
        wen = 1;
        #10;
        wen = 0;
        #10;

        wa = 5'd3;
        wd = 64'h09_0A_0B_0C_0D_0E_0F_10; // part 2
        wen = 1;
        #10;
        wen = 0;
        #10;

        wa = 5'd4;
        wd = 64'h11_12_13_14_15_16_17_18; // part 3
        wen = 1;
        #10;
        wen = 0;
        #10;
        
        wa = 5'd5;
        wd = 64'h19_1A_1B_1C_1D_1E_1F_20; // part 4
        wen = 1;
        #10;
        wen = 0;
        #10;
        
        // Write to v4 and v5
        wa = 5'd6;
        wd = 64'h01_01_01_01_01_01_01_01; // part 5
        wen = 1;
        #10;
        wen = 0;
        #10;

        wa = 5'd7;
        wd = 64'h01_01_01_01_01_01_01_01; // part 6
        wen = 1;
        #10;
        wen = 0;
        #10;
        
        wa = 5'd8;
        wd = 64'h01_01_01_01_01_01_01_01; // part 7
        wen = 1;
        #10;
        wen = 0;
        #10;
        
        wa = 5'd9;
        wd = 64'h01_01_01_01_01_01_01_01; // part 8
        wen = 1;
        #10;
        wen = 0;
        #10;

        // Start grouped operation using v2+v3 and v4+v5
        raA = 5'd2;
        raB = 5'd6;
        wa  = 5'd10; // result goes to v6+v7 (implicitly)
        #50;


        

        $display("ALU result (LMUL=2) = %h", alu_res);        

        #50;
        $finish;
    end

endmodule