//mayhaps need to change here how SEW is used
//either that or there will be a translator outside

module vALU (
        reg_in1,
        reg_in2,
        reg_scalar_in,
        valu_op,
        SEW,
        reg_dest
   );

    input[127:0]    reg_in1, reg_in2;
    input[127:0]    reg_scalar_in;
    input[2:0]      valu_op;
    input[7:0]      SEW;

    output reg [127:0] reg_dest;         

    parameter [7:0] VLEN = 8'd128; 
    integer i;

    reg [256:0] temp_mult;
    reg [127:0] temp;

    always @(*) begin

        reg_dest = 32'b0;

        case (valu_op)
            3'b000: begin   //000 -> elementwise addition
                case (SEW)
                    8'd8:   begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            reg_dest[8*i +: 8] = reg_in1[8*i +: 8] + reg_in2[8*i +: 8];
                        end
                    end
                    8'd16: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            reg_dest[16*i +: 16] = reg_in1[16*i +: 16] + reg_in2[16*i +: 16];
                        end
                    end     
                    8'd32: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            reg_dest[32*i +: 32] = reg_in1[32*i +: 32] + reg_in2[32*i +: 32];
                        end
                    end
                    8'd64: begin
                        for (i=0; i < (VLEN>>6); i=i+1) begin
                            reg_dest[64*i +: 64] = reg_in1[64*i +: 64] + reg_in2[64*i +: 64];
                        end
                    end
                    8'd128: begin
                        reg_dest = reg_in1 + reg_in2;
                    end
                endcase   
            end
            
            3'b001: begin   //001 -> vector + scalar addition (both from reg and immediate)
                case (SEW)
                    8'd8: begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            reg_dest[8*i +: 8] = reg_in1[8*i +: 8] + reg_scalar_in[7:0];
                        end
                    end
                    8'd16: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            reg_dest[16*i +: 16] = reg_in1[16*i +: 16] + reg_scalar_in[15:0];
                        end
                    end
                    8'd32: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            reg_dest[32*i +: 32] = reg_in1[32*i +: 32] + reg_scalar_in[31:0];
                        end
                    end
                    8'd64: begin
                        for (i=0; i < (VLEN>>6); i=i+1) begin
                            reg_dest[64*i +: 64] = reg_in1[64*i +: 64] + reg_scalar_in[63:0];
                        end
                    end
                    8'd128: begin
                        reg_dest = reg_in1 + reg_scalar_in;
                    end
                endcase
            end

            3'b010: begin   // 010 -> elementwise subtraction
                case (SEW)
                    8'd8:   begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            reg_dest[8*i +: 8] = reg_in1[8*i +: 8] - reg_in2[8*i +: 8];
                        end
                    end
                    8'd16: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            reg_dest[16*i +: 16] = reg_in1[16*i +: 16] - reg_in2[16*i +: 16];
                        end
                    end     
                    8'd32: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            reg_dest[32*i +: 32] = reg_in1[32*i +: 32] - reg_in2[32*i +: 32];
                        end
                    end
                    8'd64: begin
                        for (i=0; i < (VLEN>>6); i=i+1) begin
                            reg_dest[64*i +: 64] = reg_in1[64*i +: 64] - reg_in2[64*i +: 64];
                        end
                    end
                    8'd128: begin
                        reg_dest = reg_in1 - reg_in2;
                    end
                endcase   
            end

            3'b011: begin   //011 -> vector - scalar subtraction (both from reg and immediate)
                case (SEW)
                    8'd8:   begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            reg_dest[8*i +: 8] = reg_in1[8*i +: 8] - reg_scalar_in[7:0];
                        end
                    end
                    8'd16: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            reg_dest[16*i +: 16] = reg_in1[16*i +: 16] - reg_scalar_in[15:0];
                        end
                    end     
                    8'd32: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            reg_dest[32*i +: 32] = reg_in1[32*i +: 32] - reg_scalar_in[31:0];
                        end
                    end
                    8'd64: begin
                        for (i=0; i < (VLEN>>6); i=i+1) begin
                            reg_dest[64*i +: 64] = reg_in1[64*i +: 64] - reg_scalar_in[63:0];
                        end
                    end
                    8'd128: begin
                        reg_dest = reg_in1 - reg_scalar_in;
                    end
                endcase 
            end

            3'b100: begin   //100 -> elementwise multiplication
                case (SEW)
                    8'd8:   begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            temp_mult = $signed(reg_in1[8*i +: 8]) * $signed(reg_in2[8*i +: 8]);
                            reg_dest[8*i +: 8] = temp_mult[7:0];
                        end
                    end
                    8'd16: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            temp_mult = $signed(reg_in1[16*i +: 16]) * $signed(reg_in2[16*i +: 16]);
                            reg_dest[16*i +: 16] = temp_mult[15:0];
                        end
                    end     
                    8'd32: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            temp_mult = $signed(reg_in1[32*i +: 32]) * $signed(reg_in2[32*i +: 32]);
                            reg_dest[32*i +: 32] = temp_mult[31:0];
                        end
                    end
                    8'd64: begin
                        for (i=0; i < (VLEN>>6); i=i+1) begin
                            temp_mult = $signed(reg_in1[64*i +: 64]) * $signed(reg_in2[64*i +: 64]);
                            reg_dest[64*i +: 64] = temp_mult[63:0];
                        end
                    end
                    8'd128: begin
                        temp_mult = $signed(reg_in1) * $signed(reg_in2);
                        reg_dest = temp_mult[127:0];
                    end
                endcase 
            end

            3'b101: begin   //101 -> vector * scalar (both from reg and immediate)
                case (SEW)
                    8'd8:   begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            temp_mult = $signed(reg_in1[8*i +: 8]) * $signed(reg_scalar_in[7:0]);
                            reg_dest[8*i +: 8] = temp_mult[7:0];
                        end
                    end
                    8'd16: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            temp_mult = $signed(reg_in1[16*i +: 16]) * $signed(reg_scalar_in[15:0]);
                            reg_dest[16*i +: 16] = temp_mult[15:0];
                        end
                    end     
                    8'd32: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            temp_mult = $signed(reg_in1[32*i +: 32]) * $signed(reg_scalar_in[31:0]);
                            reg_dest[32*i +: 32] = temp_mult[31:0];
                        end
                    end
                    8'd64: begin
                        for (i=0; i < (VLEN>>6); i=i+1) begin
                            temp_mult = $signed(reg_in1[64*i +: 64]) * $signed(reg_scalar_in[63:0]);
                            reg_dest[64*i +: 64] = temp_mult[63:0];
                        end
                    end
                    8'd128: begin
                        temp_mult = $signed(reg_in1) * $signed(reg_scalar_in);
                        reg_dest = temp_mult[127:0];
                    end
                endcase
            end

            3'b110: begin   //find min
                temp = 128'b0;
                case (SEW)
                    8'd8: begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            if (temp > $signed(reg_in1)) begin
                                temp = reg_in1;
                            end
                        end
                        reg_dest = temp;
                    end
                    8'd16: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            if (temp > $signed(reg_in1)) begin
                                temp = reg_in1;
                            end
                        end
                        reg_dest = temp;
                    end
                    8'd32: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            if (temp > $signed(reg_in1)) begin
                                temp = reg_in1;
                            end
                        end
                        reg_dest = temp;
                    end
                    8'd64: begin
                        for (i=0; i < (VLEN>>6); i=i+1) begin
                            if (temp > $signed(reg_in1)) begin
                                temp = reg_in1;
                            end
                        end
                        reg_dest = temp;
                    end
                    8'd128: begin
                        reg_dest = reg_in1;
                    end
                endcase
            end

            3'b111: begin   //find max
                temp = 128'b0;
                case (SEW)
                    8'd8: begin
                        for (i=0; i < (VLEN>>3); i=i+1) begin
                            if (temp < $signed(reg_in1)) begin
                                temp = reg_in1;
                            end
                        end
                        reg_dest = temp;
                    end
                    8'd16: begin
                        for (i=0; i < (VLEN>>4); i=i+1) begin
                            if (temp < $signed(reg_in1)) begin
                                temp = reg_in1;
                            end
                        end
                        reg_dest = temp;
                    end
                    8'd32: begin
                        for (i=0; i < (VLEN>>5); i=i+1) begin
                            if (temp < $signed(reg_in1)) begin
                                temp = reg_in1;
                            end
                        end
                        reg_dest = temp;
                    end
                    8'd64: begin
                        for (i=0; i < (VLEN>>6); i=i+1) begin
                            if (temp < $signed(reg_in1)) begin
                                temp = reg_in1;
                            end
                        end
                        reg_dest = temp;
                    end
                    8'd128: begin
                        reg_dest = reg_in1;
                    end
                endcase
            end         
            default:    begin
                            reg_dest = 32'b0;
                        end
        endcase
    end

endmodule
