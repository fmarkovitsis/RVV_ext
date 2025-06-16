module tb;
    reg [2:0] SEW_encoded, lmul_encoded;

    wire [7:0] SEW;
    wire [4:0] lmul;
    wire valid;

    translate trnsl (SEW_encoded, lmul_encoded, SEW, lmul, valid);

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);

        SEW_encoded = 3'b111;
        lmul_encoded = 3'b111;

        #10;
        SEW_encoded = 3'b101;   lmul_encoded = 3'b100;
        #10;
        SEW_encoded = 3'b100;   lmul_encoded = 3'b101;
        #10;
        SEW_encoded = 3'b100;   lmul_encoded = 3'b100;
        #10;
        SEW_encoded = 3'b010;   lmul_encoded = 3'b100;
        #10;
        SEW_encoded = 3'b000;   lmul_encoded = 3'b010;
        #10;
        SEW_encoded = 3'b100;   lmul_encoded = 3'b100;
        #10;
        SEW_encoded = 3'b000;   lmul_encoded = 3'b000;
    end
        
        
endmodule