// TODO:
// σημα για LMUL>1 να κανει stall τα σταδιο IF1/IF2
// VL for min/max ops
// LMUL < 1 


module grouping_selector (
    input [4:0] raA, raB, rdest,
    // input [2:0] SEW_encoded, // maybe for vl for min/max ops
    // input [8:0] AVL, // maybe for vl for min/max ops
    input [2:0] lmul_reg, // encoded LMUL from vregfile 
    input [3:0] lmul_group, // decoded LMUL from the previous grouping_selector operation output
    input lmul_stall_in, // stall signal for the grouping selector

    output reg [3:0] lmul_out, // decoded lmul output
    output reg lmul_stall_out,
    output reg [4:0] raA_out, raB_out, rdest_out // outputs for the alu operations 

);

    parameter [3:0] MAX_LMUL = 4'd8;
    wire [3:0] lmul_in;
    reg [3:0] lmul_reg_decoded;

    assign lmul_in = (lmul_stall_in) ? lmul_group : lmul_reg_decoded; // Use the lmul from the previous grouping selector operation output


    always @(*) begin
        case (lmul_reg)
            3'b000: lmul_reg_decoded = 4'd1; // LMUL = 1
            3'b001: lmul_reg_decoded = 4'd2; // LMUL = 2
            3'b010: lmul_reg_decoded = 4'd4; // LMUL = 4
            3'b011: lmul_reg_decoded = 4'd8; // LMUL = 8
            default: lmul_reg_decoded = MAX_LMUL; // Default to MAX_LMUL if invalid input
        endcase
    end


    always @(*) begin
        

        lmul_out = lmul_reg_decoded - 1'd1;
        raA_out = raA + (lmul_reg_decoded - lmul_in);
        raB_out = raB + (lmul_reg_decoded - lmul_in);
        rdest_out = rdest + (lmul_reg_decoded - lmul_in);
        
        if ((lmul_in - 1'd1) > 0) begin
            lmul_stall_out = 1'b1;
        end
        else begin 
            lmul_stall_out = 1'b0; // no stall signal for the grouping selector
        end        
    end

endmodule
