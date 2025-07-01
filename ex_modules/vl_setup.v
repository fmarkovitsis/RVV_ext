`ifndef TESTBENCH
`include "constants.vh"
`include "config.vh"
`else
`include "../includes/constants.vh"
`include "../includes/config.vh"
`endif


// SEW/LMUL:
// 000 -> 8 bits  / x1
// 001 -> 16 bits / x2
// 010 -> 32 bits / x4
// 011 -> 64 bits / x8


module vl_setup (
    input[2:0] SEW, 	//encoded
    input[2:0] lmul, 	//encoded
    input[6:0] AVL,
    input vcsr_wen,

    output reg [6:0] new_vl,
    output reg [6:0] new_AVL,
    output reg [6:0] new_vtype
);

    reg [6:0] curr_vlmax;

    parameter [6:0] VLEN = 7'd64; 

    always @(*) begin

        if (vcsr_wen == 1'b1) begin
            if ((SEW[2] == 1'b1) || (lmul[2] == 1'b1)) begin
                new_vtype[6] = 1'b0;
            end
            else begin
                new_vtype[6] = 1'b1;
            end
        end
        else begin
            new_vtype[6] = 1'b0;
        end

        curr_vlmax = (VLEN >> (SEW + 3)) * (1 << lmul);

        if (new_vtype[6] == 1'b1) begin
            new_vtype[2:0] = lmul;
            new_vtype[5:3] = SEW;
            
            if (curr_vlmax <= AVL) begin   /// may need to add stall mechanism there
                    new_vl = curr_vlmax;
                    new_AVL = AVL - curr_vlmax;
            end
            else begin
                new_vl = AVL;
                new_AVL = 7'd0;
            end
        end
        else begin // to avoid latches
            new_vl = 7'd0;
            new_AVL = 7'd0;
            new_vtype = 7'b0;
        end
    end

endmodule
