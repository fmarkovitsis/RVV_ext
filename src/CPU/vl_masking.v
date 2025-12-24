module vl_masking ( //st
    input [63:0] vALU_Out,
    input [2:0] grouping_cnt,
    input [6:0] vtype_alu,
    inout [6:0] vl, 
    
    output reg [63:0] masked_vALU_Out
);
reg [3:0] temp;      //has to be max = 8. useful elements of last vector reg
reg [63:0] mask;
reg [63:0] mask_inv;

parameter VLEN = 7'd64;

always @(*) begin
    temp = 0;
    mask = 0;

    if (grouping_cnt < (1 << vtype_alu[2:0])-1) begin
        masked_vALU_Out = vALU_Out;
    end
    else begin
        temp = vl - ((VLEN >> (vtype_alu[5:3] + 2'd3)) * ((1 << vtype_alu[2:0]) - 1'b1));
        mask = 64'hffffffff << (temp * (1 << (vtype_alu[5:3] + 2'd3)));
        mask_inv = ~mask;

        masked_vALU_Out = vALU_Out & mask_inv;
    end
end
    
endmodule