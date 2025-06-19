module tb;
    reg [7:0] SEW;
    reg [4:0] lmul;
    reg [8:0] AVL;

    wire valid;
    wire [8:0] vl, new_AVL;

    vl_setup ihml (SEW, lmul, AVL, valid, vl, new_AVL);

    initial begin
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);

        SEW = 0;
        lmul = 0;
        AVL = 0;

        #10;
        SEW = 8'd64; lmul = 5'd4; AVL = 9'd9;

        #10;
        SEW = 8'd64; lmul = 5'd4; AVL = 9'd5;

        #10;
        SEW = 8'd44; lmul = 5'd2; AVL = 9'd5;

        #10;
        SEW = 8'd64; lmul = 5'd5; AVL = 9'd5;

        #10;
        SEW = 8'd8; lmul = 5'd16; AVL = 9'd256;

        #10;
        SEW = 8'd8; lmul = 5'd16; AVL = 9'd500;
    
        #10;
        SEW = 8'd128; lmul = 5'd16; AVL = 9'd600; //overflow
    end


endmodule

//avl is not really 9 bits