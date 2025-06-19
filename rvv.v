module RVV(
    input clk,
    input rst,
    input [2:0] sew_encoded,
    input [2:0] lmul_encoded,
    input [8:0] AVL,                // Current available vector length
    input [4:0] raA, raB, wa,      // Read addresses A/B, write address
    input [127:0] wd,              // Write data
    input wen,                     // Write enable for vector registers
    output [127:0] alu_res
);

wire [7:0] SEW_decoded;
wire [4:0] LMUL_decoded; 
wire reset_debounced;
wire valid_lmul, valid_sew;
wire vsetup_en;
wire [8:0] vl_in;
wire [2:0] valu_op;
wire [127:0] alu_scalar_in;
wire [8:0] new_AVL;
wire [8:0] vl;

button_synchronizer button_sync (
    .clk(clk),
    .button(rst),
    .new_button(reset_debounced)
);

vtype_decoder vtype_decoder_unit (
    .SEW_encoded(sew_encoded),
    .lmul_encoded(lmul_encoded),
    .SEW(SEW_decoded),
    .lmul(LMUL_decoded),
    .valid_lmul(valid_lmul),
    .valid_sew(valid_sew)
);

vl_setup vl_setup_unit (            //will problably change with the
    .SEW(SEW_decoded),              //implementation of vsetvl
    .lmul(LMUL_decoded),            //or at least be updated
    .AVL(AVL),
    .valid_lmul(valid_lmul),
    .valid_sew(valid_sew),
    .vsetup_en(vsetup_en),
    .vl(vl_in),
    .new_AVL(new_AVL)
);

vRegFile vRegFile_unit (
    .clk(clk),
    .rst(reset_debounced),
    .raA(raA),
    .raB(raB),
    .wa(wa),
    .wd(wd),    
    .wen(wen),
    .vl_in(idex_vl_in),
    .AVL_in(idex_new_AVL),
    .vtype_in({idex_vsetup_en, idex_sew_encoded, idex_lmul_encoded}),
    .rdA(rdA),
    .rdB(rdB),
    .vl(vl),
    .vtype(vtype),
    .AVL_reg(AVL_reg)
);

////////////////////////////////////////////////////////////
reg idex_vsetup_en;
reg [2:0] idex_sew_encoded, idex_lmul_encoded;
reg [6:0] idex_vtype;
reg [8:0] idex_new_AVL;
reg [8:0] idex_vl_in;
reg [8:0] idex_vl;
reg [31:0] idex_alu_scalar_in;
reg [127:0] idex_rdA, idex_rdB;

always@(posedge clk) begin
    if (!rst) begin
        idex_lmul_encoded <= 0;
        idex_sew_encoded <= 0;
        idex_vsetup_en <= 0;
        idex_vtype <= 0;
        idex_vl_in <= 0;
        idex_alu_scalar_in <= 0;
        idex_rdA <= 0;
        idex_rdB <= 0;
        idex_new_AVL <= 0;
        idex_vl <= 0;
    end
    else begin
        idex_lmul_encoded <= lmul_encoded;
        idex_sew_encoded <= sew_encoded;
        idex_vsetup_en <= vsetup_en;
        idex_vtype <= vtype;
        idex_vl_in <= vl_in;
        idex_alu_scalar_in <= alu_scalar_in;
        idex_rdA <= rdA;
        idex_rdB <= rdB;
        idex_new_AVL <= new_AVL;
        idex_vl <= vl;
    end
end
////////////////////////////////////////////////////////////

vALU alu_unit (
    .reg_inA(idex_rdA),
    .reg_inB(idex_rdB),
    .reg_scalar_in(idex_alu_scalar_in),
    .valu_op(valu_op),
    .SEW(idex_vtype[5:3]),
    .reg_dest(alu_res)
);

endmodule