module RVV(
    input clk,
    input rst,
    input [3:0] valu_op,
    input [2:0] sew_encoded_id,
    input [2:0] lmul_encoded_id,
    input [7:0] AVL,                // Current available vector length
    input [4:0] raA, raB, wa,      // Read addresses A/B, write address
    input [63:0] wd,              // Write data
    input [31:0] alu_scalar_in_id,
    input wen,                     // Write enable for vector registers
    output [63:0] alu_res
);

wire [6:0] SEW_decoded;
wire [3:0] LMUL_decoded; 
wire reset_debounced;
wire valid_lmul, valid_sew;
wire vsetup_en_id;
wire [7:0] vl_in_id;
wire [7:0] avl_in_id;
wire [7:0] vl_id;
wire [6:0] vtype_id;
wire [7:0] avl_id;
wire [63:0] rdA_id, rdB_id;          // Read data A/B

button_synchronizer button_sync (
    .clk(clk),
    .button(rst),
    .new_button(reset_debounced)
);

vtype_decoder vtype_decoder_unit (
    .SEW_encoded(sew_encoded_id),
    .LMUL_encoded(lmul_encoded_id),
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
    .vsetup_en(vsetup_en_id),
    .vl(vl_in_id),
    .new_AVL(avl_in_id)
);

////////////////////////////////////////////////////////////
reg vsetup_en_ex;
reg [2:0] sew_encoded_ex, lmul_encoded_ex;
reg [6:0] vtype_ex;
reg [7:0] avl_in_ex;
reg [7:0] vl_in_ex;
reg [7:0] vl_ex;
reg [31:0] alu_scalar_in_ex;
reg [63:0] rdA_ex, rdB_ex;
reg [7:0] avl_ex;

reg [3:0] lmul_ex;
wire [3:0] lmul_id;
reg [2:0] cnt_ex;
wire [2:0] cnt_id;
wire stall_reg;
wire [4:0] raA_group, raB_group, rdest_group;
wire [4:0] vl_per_reg_id;
reg [4:0] vl_per_reg_ex;
////////////////////////////////////////////////////////////

vRegFile vRegFile_unit (
    .clk(clk),
    .rst(reset_debounced),
    .raA(raA_group),
    .raB(raB_group),
    .wa(rdest_group),
    .wd(wd),    
    .wen(wen),
    .vl_in(vl_in_ex),
    .AVL_in(avl_in_ex),
    .vtype_in({vsetup_en_ex, sew_encoded_ex, lmul_encoded_ex}),
    .rdA(rdA_id),
    .rdB(rdB_id),
    .vl(vl_id),
    .vtype(vtype_id),
    .AVL_reg(avl_id)
);



grouping_selector grouping_selector_unit (
    .raA(raA),
    .raB(raB),
    .rdest(wa),
    .lmul_reg(vtype_id[2:0]), // encoded LMUL from vregfile 
    .cnt_in(cnt_ex),
    
    .cnt_out(cnt_id),
    .stall(stall_reg),
    .raA_out(raA_group),
    .raB_out(raB_group),
    .rdest_out(rdest_group)
);

// vl_per_reg_calculator vl_per_reg_calculator_unit (
//     .lmul_reg(vtype_id[2:0]), // encoded LMUL from vregfile
//     .vl(vl_id),
//     .vl_per_reg(vl_per_reg_id) // VL per register output
// );

always@(posedge clk) begin
    if (!rst) begin
        lmul_encoded_ex <= 3'd0;
        sew_encoded_ex <= 3'd0;
        vsetup_en_ex <= 1'd0;
        vtype_ex <= 7'd0;
        vl_in_ex <= 9'd0;
        alu_scalar_in_ex <= 32'd0;
        rdA_ex <= 64'd0;
        rdB_ex <= 64'd0;
        avl_in_ex <= 9'd0;
        vl_ex <= 9'd0;
        avl_ex <= 9'd0;
        lmul_ex <= 4'd0;
        cnt_ex <= 3'b0;
        vl_per_reg_ex <= 5'd0;
    end
    else begin
        lmul_encoded_ex <= lmul_encoded_id;
        sew_encoded_ex <= sew_encoded_id;
        vsetup_en_ex <= vsetup_en_id;
        vtype_ex <= vtype_id;
        vl_in_ex <= vl_in_id;
        alu_scalar_in_ex <= alu_scalar_in_id;
        rdA_ex <= rdA_id;
        rdB_ex <= rdB_id;
        avl_in_ex <= avl_in_id;
        vl_ex <= vl_id;
        avl_ex <= avl_id;
        lmul_ex <= lmul_id;
        cnt_ex <= cnt_id;
        vl_per_reg_ex <= vl_per_reg_id;
    end
end
////////////////////////////////////////////////////////////

vALU alu_unit (
    .reg_in1(rdA_ex),
    .reg_in2(rdB_ex),
    .reg_scalar_in({{32{alu_scalar_in_ex[31]}}, alu_scalar_in_ex}),
    .valu_op(valu_op),
    .SEW(vtype_ex[5:3]),
    .result(alu_res)
);

endmodule