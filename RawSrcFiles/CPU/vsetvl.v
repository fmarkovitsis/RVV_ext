// `ifndef TESTBENCH
`include "constants.vh"
`include "config.vh"
// `else
// `include "../includes/constants.vh"
// `include "../includes/config.vh"
// `endif


module vsetvl (         //we are currently recognising only vsetivli and vsetvli
    input [6:0] opcode, //vsetvl would be redundant. it might be be added in the 
    input [2:0] funct3, //future
    input       imm_ind2,
    input [6:0] AVL_reg,
    input [4:0] AVL_imm,
    input [10:0] zimm,
    input [9:0] vtypei,

    output reg [2:0] SEW,
    output reg [2:0] lmul,
    output reg [6:0] AVL,
    output reg vcsr_wen
);

    always @(*) begin
        if ((opcode == `VR_FORMAT) && (funct3  == `VC_FORMAT)) begin
            if (imm_ind2 == 1'b1) begin //if we have vsetivli
                lmul = vtypei [2:0];
                SEW = vtypei [5:3];
                AVL = {2'b00, AVL_imm};
                vcsr_wen = 1'b1;
            end
            else begin                  //if we have vsetvli
                lmul = zimm [2:0];
                SEW = zimm [5:3];
                AVL = AVL_reg;
                vcsr_wen = 1'b1;
            end
        end
        else begin
            SEW = 3'b111;
            lmul = 3'b111;
            AVL = 7'b0;
            vcsr_wen = 1'b0;
        end


    end

endmodule