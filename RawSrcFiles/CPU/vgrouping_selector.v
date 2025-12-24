// TODO:
// σημα για LMUL>1 να κανει stall τα σταδιο IF1/IF2
// VL for min/max ops
// LMUL < 1 


module grouping_selector (
    input [4:0] raA, raB, rdest,
    input [2:0] lmul_reg, // encoded LMUL from vregfile 
    input [2:0] cnt_in,
    input grouping_enable, 
    
    output wire [2:0] cnt_out, 
    output wire stall,
    output wire [4:0] raA_out, raB_out, rdest_out // outputs for the alu operations 

);

    reg [3:0] lmul_reg_decoded;

    always @(*) begin
        case (lmul_reg)
            3'b000: lmul_reg_decoded = 4'd1; // LMUL = 1
            3'b001: lmul_reg_decoded = 4'd2; // LMUL = 2
            3'b010: lmul_reg_decoded = 4'd4; // LMUL = 4
            3'b011: lmul_reg_decoded = 4'd8; // LMUL = 8
            default: lmul_reg_decoded = 4'd0; // Default to MAX_LMUL if invalid input
        endcase
    end



    assign stall = ((cnt_in < lmul_reg_decoded - 1) && grouping_enable) ? 1'd1 : 1'd0;
    assign cnt_out = ((cnt_in < lmul_reg_decoded - 1) && grouping_enable) ? cnt_in + 1'd1 : 3'd0;
    assign rdest_out = rdest + cnt_in;
    assign raA_out = raA + cnt_in;
    assign raB_out = raB + cnt_in;

endmodule