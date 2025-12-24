module vl_masking (
    input [63:0] reg_in1,
    input [63:0] reg_in2,
    input [3:0] lmul_id,   //this is how many iterations are left for reg grouping operation to finish
    input [6:0] vl,
    input [6:0] vtype,
    
    output reg [63:0] reg_in1_fin,
    output reg [63:0] reg_in2_fin
);
reg [3:0] current;      //last vectors length. has to be max = 8
reg [63:0] mask;

parameter VLEN = 7'd64;

always @(*) begin
    current = 0;
    mask = 0;

    if (lmul_id > 1'b1) begin
        reg_in1_fin = reg_in1;
        reg_in2_fin = reg_in2;
    end
    else begin
        current = vl - ((VLEN >> (vtype[5:3] + 2'd3)) * ((1 << vtype[2:0]) - 1));
        mask = 64'hffffffff << (current * (1 << (vtype[5:3] + 3)));

        reg_in1_fin = reg_in1 * mask;
        reg_in2_fin = reg_in2 * mask;
    end
end
    
endmodule