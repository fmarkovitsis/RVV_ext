module vcontrol_bypass (
    input [4:0] IDEX_instr_vrs1,
    input [4:0] IDEX_instr_vrs2,
    input [4:0] EXMEM_instr_vrd,
    input [4:0] MEMWB_instr_vrd,
    input [63:0] IDEX_rdvA,
    input [63:0] IDEX_rdvB,
    input [63:0] EXMEM_vALU_Out,
    input [63:0] MEMWB_vALU_Out,
    
    output [63:0] bypassOutvA,
    output [63:0] bypassOutvB
);

    always @(*) begin
        if (IDEX_instr_vrs1 == EXMEM_instr_vrd) begin
            bypassOutvA = EXMEM_vALU_Out;
        end
        else if (IDEX_instr_vrs1 == MEMWB_instr_vrd) begin
            bypassOutvA = MEMWB_vALU_Out;
        end
        else begin
            bypassOutvA = IDEX_rdvA;
        end
    end

    always @(*) begin
        if (IDEX_instr_vrs2 == EXMEM_instr_vrd) begin
            bypassOutvB = EXMEM_vALU_Out;
        end
        else if (IDEX_instr_vrs2 == MEMWB_instr_vrd) begin
            bypassOutvB = MEMWB_vALU_Out;
        end
        else begin
            bypassOutvB = IDEX_rdvB;
        end
    end

endmodule