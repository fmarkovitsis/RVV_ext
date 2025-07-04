// SEW:
// 000 -> 8 bits
// 001 -> 16 bits
// 010 -> 32 bits
// 011 -> 64 bits


module vl_setup (
        SEW,
        lmul,
        AVL,
        valid_lmul,
        valid_sew,
        vsetup_en,
        vl,
        new_AVL
    );

    input[2:0] SEW; 	//encoded
    input[2:0] lmul; 	//encoded
    input[6:0] AVL;
    input valid_lmul;
    input valid_sew;

    output vsetup_en;
    output reg [6:0] vl;
    output reg [6:0]  new_AVL;

    reg [6:0] curr_vlmax;
    reg [2:0] temp;

    parameter [6:0] VLEN = 8'd64; 
    integer i;


    assign vsetup_en = valid_sew && valid_lmul;

    always @(*) begin
        
        curr_vlmax = (VLEN >> (SEW + 3)) * (1 << lmul);


        if (valid_lmul && valid_sew) begin
            if (curr_vlmax <= AVL) begin   /// may need to add stall mechanism there
                    vl = curr_vlmax;
                    new_AVL = AVL - curr_vlmax;
            end
            else begin
                vl = AVL;
                new_AVL = 7'd0;
            end
        end
        else begin // to avoid latches
            vl = 7'd0;
            new_AVL = 7'd0;
        end
    end

endmodule
