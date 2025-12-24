//mayhaps need to change here how SEW is used
//either that or there will be a translator outside
// `ifndef TESTBENCH
`include "constants.vh"
`include "config.vh"
// `else
// `include "../includes/constants.vh"
// `include "../includes/config.vh"
// `endif
//mayhaps need to change here how SEW is used
//either that or there will be a translator outside

module vALU (
        reg_in1,
        reg_in2,
        reg_scalar_in,
        valu_op,
        SEW,
        result
   );

    input[63:0]    reg_in1, reg_in2;
    input[63:0]    reg_scalar_in;
    input[3:0]      valu_op;
    input[2:0]      SEW;

    output reg [63:0] result;         

    parameter [6:0] VLEN = 7'd64; 
    integer i;

    reg [127:0] temp_mult;
    reg [63:0] temp;

    always @(*) begin

        result = 64'b0;

        case (valu_op)
            4'b0000: begin   //000 -> elementwise addition
                case (SEW)
                    3'b000:   begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            result[8*i +: 8] = reg_in1[8*i +: 8] + reg_in2[8*i +: 8];
                        end
                    end
                    3'b001: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            result[16*i +: 16] = reg_in1[16*i +: 16] + reg_in2[16*i +: 16];
                        end
                    end     
                    3'b010: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            result[32*i +: 32] = reg_in1[32*i +: 32] + reg_in2[32*i +: 32];
                        end
                    end
                    3'b011: begin
                        result = reg_in1 + reg_in2;
                    end
                    default: begin
                        result = 64'b0; //to avoid latches
                    end
                endcase   
            end
            
            4'b0001: begin   //001 -> vector + scalar addition (both from reg and immediate)
                case (SEW)
                    3'b000: begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            result[8*i +: 8] = reg_in2[8*i +: 8] + reg_scalar_in[7:0];
                        end
                    end
                    3'b001: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            result[16*i +: 16] = reg_in2[16*i +: 16] + reg_scalar_in[15:0];
                        end
                    end
                    3'b010: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            result[32*i +: 32] = reg_in2[32*i +: 32] + reg_scalar_in[31:0];
                        end
                    end
                    3'b011: begin
                         result = reg_in2 + reg_scalar_in;
                    end
                    default: begin
                        result = 64'b0; //to avoid latches
                    end
                endcase
            end

            4'b0010: begin   // 010 -> elementwise subtraction
                case (SEW)
                    3'b000:   begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            result[8*i +: 8] = reg_in2[8*i +: 8] - reg_in1[8*i +: 8];
                        end
                    end
                    3'b001: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            result[16*i +: 16] = reg_in2[16*i +: 16] - reg_in1[16*i +: 16];
                        end
                    end     
                    3'b010: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            result[32*i +: 32] = reg_in2[32*i +: 32] - reg_in1[32*i +: 32];
                        end
                    end
                    3'b011: begin
                        result = reg_in2 - reg_in1;
                    end
                    default: begin
                        result = 64'b0; //to avoid latches
                    end
                endcase   
            end

            4'b0011: begin   //011 -> vector - scalar subtraction (both from reg and immediate)
                case (SEW)
                    3'b000:   begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            result[8*i +: 8] = reg_in2[8*i +: 8] - reg_scalar_in[7:0];
                        end
                    end
                    3'b001: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            result[16*i +: 16] = reg_in2[16*i +: 16] - reg_scalar_in[15:0];
                        end
                    end     
                    3'b010: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            result[32*i +: 32] = reg_in2[32*i +: 32] - reg_scalar_in[31:0];
                        end
                    end
                    3'b011: begin
                        result = reg_in2 - reg_scalar_in;
                    end
                    default: begin
                        result = 64'b0; //to avoid latches
                    end
                endcase 
            end

            4'b0100: begin   //100 -> elementwise multiplication
                case (SEW)
                    3'b000:   begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            temp_mult = $signed(reg_in1[8*i +: 8]) * $signed(reg_in2[8*i +: 8]);
                            result[8*i +: 8] = temp_mult[7:0];
                        end
                    end
                    3'b001: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            temp_mult = $signed(reg_in1[16*i +: 16]) * $signed(reg_in2[16*i +: 16]);
                            result[16*i +: 16] = temp_mult[15:0];
                        end
                    end     
                    3'b010: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            temp_mult = $signed(reg_in1[32*i +: 32]) * $signed(reg_in2[32*i +: 32]);
                            result[32*i +: 32] = temp_mult[31:0];
                        end
                    end
                    3'b011: begin
                        temp_mult = $signed(reg_in1) * $signed(reg_in2);
                        result = temp_mult[63:0];
                    end
                    default: begin
                        result = 64'b0; //to avoid latches
                    end
                endcase 
            end

            4'b0101: begin   //101 -> vector * scalar (both from reg and immediate)
                case (SEW)
                    3'b000:   begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            temp_mult = $signed(reg_in2[8*i +: 8]) * $signed(reg_scalar_in[7:0]);
                            result[8*i +: 8] = temp_mult[7:0];
                        end
                    end
                    3'b001: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            temp_mult = $signed(reg_in2[16*i +: 16]) * $signed(reg_scalar_in[15:0]);
                            result[16*i +: 16] = temp_mult[15:0];
                        end
                    end     
                    3'b010: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            temp_mult = $signed(reg_in2[32*i +: 32]) * $signed(reg_scalar_in[31:0]);
                            result[32*i +: 32] = temp_mult[31:0];
                        end
                    end
                    3'b011: begin
                        temp_mult = $signed(reg_in2) * $signed(reg_scalar_in);
                        result = temp_mult[63:0];
                    end
                    default: begin
                        result = 64'b0; //to avoid latches
                    end
                endcase
            end

            4'b0110: begin //and 		logical vector operations are NOT tested yet.
                result = reg_in1 & reg_in2;  
            end
            
            4'b0111: begin //and vector - scalar
                case (SEW)
                    3'b000:   begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            result[8*i +: 8] = reg_in2[8*i +: 8] & reg_scalar_in[7:0];
                        end
                    end
                    3'b001: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            result[16*i +: 16] = reg_in2[16*i +: 16] & reg_scalar_in[15:0];
                        end
                    end     
                    3'b010: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            result[32*i +: 32] = reg_in2[32*i +: 32] & reg_scalar_in[31:0];
                        end
                    end
                    3'b011: begin
                        result = reg_in2 & reg_scalar_in;
                    end
                    default: begin
                        result = 64'b0; //to avoid latches
                    end
                endcase 
            end

            4'b1000: begin //or
                result = reg_in1 | reg_in2;
            end
            
            4'b1001: begin
                case (SEW)
                    3'b000:   begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            result[8*i +: 8] = reg_in2[8*i +: 8] | reg_scalar_in[7:0];
                        end
                    end
                    3'b001: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            result[16*i +: 16] = reg_in2[16*i +: 16] | reg_scalar_in[15:0];
                        end
                    end     
                    3'b010: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            result[32*i +: 32] = reg_in2[32*i +: 32] | reg_scalar_in[31:0];
                        end
                    end
                    3'b011: begin
                        result = reg_in2 & reg_scalar_in;
                    end
                    default: begin
                        result = 64'b0; //to avoid latches
                    end
                endcase 
            end

            4'b1010: begin //xor
                result = reg_in1 ^ reg_in2;
            end
            
            4'b1011: begin //xor vector - scalar
                case (SEW)
                    3'b000:   begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            result[8*i +: 8] = reg_in2[8*i +: 8] ^ reg_scalar_in[7:0];
                        end
                    end
                    3'b001: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            result[16*i +: 16] = reg_in2[16*i +: 16] ^ reg_scalar_in[15:0];
                        end
                    end     
                    3'b010: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            result[32*i +: 32] = reg_in2[32*i +: 32] &^ reg_scalar_in[31:0];
                        end
                    end
                    3'b011: begin
                        result = reg_in2 ^ reg_scalar_in;
                    end
                    default: begin
                        result = 64'b0; //to avoid latches
                    end
                endcase 
            end
            default:    begin
                            result = 64'b0;
                        end
        endcase
    end

endmodule