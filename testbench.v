module testbench;
    reg [127:0] in1, in2;
    reg [2:0]   valu_op;
    reg [7:0]   SEW;
    
    reg[127:0]    reg_scalar_in;

    wire [127:0] reg_dest;

    reg [7:0]   reg_dest_8 [0:15];
    reg [15:0]  reg_dest_16 [0:7];
    reg [31:0]  reg_dest_32 [0:3];
    reg [63:0]  reg_dest_64 [0:1];
    reg [127:0] reg_dest_128;

    reg [7:0]   in1_8 [0:15];
    reg [15:0]  in1_16 [0:7];
    reg [31:0]  in1_32 [0:3];
    reg [63:0]  in1_64 [0:1];
    reg [127:0] in1_128;

    reg [7:0]   in2_8 [0:15];
    reg [15:0]  in2_16 [0:7];
    reg [31:0]  in2_32 [0:3];
    reg [63:0]  in2_64 [0:1];
    reg [127:0] in2_128;
    integer i;

    vALU alu1(.reg_dest(reg_dest), .reg_in1(in1), .reg_in2(in2), .valu_op(valu_op), .SEW(SEW), .reg_scalar_in(reg_scalar_in));

    always @(*) begin
        for (i = 0; i < 16; i = i + 1)
            reg_dest_8[i] = reg_dest[127 - i*8 -: 8];
        for (i = 0; i < 8; i = i + 1)
            reg_dest_16[i] = reg_dest[127 - i*16 -: 16];
        for (i = 0; i < 4; i = i + 1)
            reg_dest_32[i] = reg_dest[127 - i*32 -: 32];
        for (i = 0; i < 2; i = i + 1)
            reg_dest_64[i] = reg_dest[127 - i*64 -: 64];
        reg_dest_128 = reg_dest;
    end

    always @(*) begin
        for (i = 0; i < 16; i = i + 1)
            in1_8[i] = in1[127 - i*8 -: 8];
        for (i = 0; i < 8; i = i + 1)
            in1_16[i] = in1[127 - i*16 -: 16];
        for (i = 0; i < 4; i = i + 1)
            in1_32[i] = in1[127 - i*32 -: 32];
        for (i = 0; i < 2; i = i + 1)
            in1_64[i] = in1[127 - i*64 -: 64];
        in1_128 = in1;
    end

    always @(*) begin
        for (i = 0; i < 16; i = i + 1)
            in2_8[i] = in2[127 - i*8 -: 8];
        for (i = 0; i < 8; i = i + 1)
            in2_16[i] = in2[127 - i*16 -: 16];
        for (i = 0; i < 4; i = i + 1)
            in2_32[i] = in2[127 - i*32 -: 32];
        for (i = 0; i < 2; i = i + 1)
            in2_64[i] = in2[127 - i*64 -: 64];
        in2_128 = in2;
    end


    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0, testbench);

        in1 = 128'h0000_0000_0000_0000_0000_0000_0000_0000;
        in2 = 128'h0000_0000_0000_0000_0000_0000_0000_0000;
        valu_op = 3'b000;
        SEW = 8;

        #10 valu_op = 3'b000;
            in1 = 128'hf840_00AA_8000_0000_4840_00AA_8000_0000;
            in2 = 128'hf448_00D5_0000_0000_4448_00D5_0000_0000;

        #10 SEW = 8;
        #10 SEW = 16;
        #10 SEW = 32;
        #10 SEW = 64;
        #10 SEW = 128;

        #10 $finish;
    end

endmodule
