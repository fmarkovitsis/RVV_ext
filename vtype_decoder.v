module vtype_decoder (
        SEW_encoded,
        LMUL_encoded,
        SEW,
        lmul,
        valid_lmul,
        valid_sew
    );

    input [2:0] SEW_encoded, LMUL_encoded;

    output reg [6:0] SEW;
    output reg [4:0] lmul;
    output reg valid_lmul, valid_sew;

    always @(*) begin 
        valid_sew = 1'd1;
        SEW = 7'b0;
        
        case (SEW_encoded)

            3'b000: SEW = 7'd4;
            3'b001: SEW = 7'd8; 
            3'b010: SEW = 7'd16; 
            3'b011: SEW = 7'd32;
            3'b100: SEW = 7'd64;
            default: begin
                
                valid_sew = 1'd0;
            end
        endcase
    end

    always @(*) begin 
        valid_lmul = 1'd1;
        lmul = 3'b0;
        
        case (LMUL_encoded)
            3'b000: lmul = 5'd1;
            3'b001: lmul = 5'd2; 
            3'b010: lmul = 5'd4; 
            3'b011: lmul = 5'd8;
            3'b100: lmul = 5'd16;
            default: begin
                lmul = lmul;
                valid_lmul = 1'd0;
            end
        endcase
    end

endmodule