module vl_setup (
        SEW,
        lmul,
        AVL,
        valid_lmul,
        valid_sew,
        vsetup_en,
        vl,
        new_AVL
    );

    input[7:0] SEW;
    input[4:0] lmul;
    input[8:0] AVL;
    input valid_lmul;
    input valid_sew;

    output reg vsetup_en;
    output reg [8:0] vl;
    output reg [8:0]  new_AVL;

    reg [8:0] curr_vlmax;
    reg [2:0] temp;

    parameter [7:0] VLEN = 8'd128; 
    integer i;


    assign vsetup_en = valid_sew && valid_lmul;

    always @(*) begin
        case (SEW)
            8'd8: begin
                temp = 3'd3;
            end
            8'd16: begin
                temp = 3'd4;
            end
            8'd32: begin
                temp = 3'd5;
            end
            8'd64: begin
                temp = 3'd6;
            end
            8'd128: begin
                temp = 3'd7;
            end
            default: begin
                valid = 1'b0;
                temp = 0;
            end
        endcase
        
        curr_vlmax = (VLEN >> temp) * lmul;

        if (curr_vlmax <= AVL) begin
            vl = curr_vlmax;
            new_AVL = AVL - curr_vlmax;
        end
        else begin
            if (valid_lmul && valid_sew) begin
            vl = AVL;
            new_AVL = 0;
            end
        end
    end

endmodule

//new problem: they cannot be encoded! in reallity,
//current_vlmax = (vlen/sew)*lmul

///////////////////////////////////////////////////////////////////////////
// sew:
// 000 -> 8
// 001 -> 16
// 010 -> 32
// 011 -> 64
// 100 -> 128

// lmul:
// 000 -> 1
// 001 -> 2
// 010 -> 4
// 011 -> 8
// 100 -> 16

// AVL -> max = 256
//        8 bits, 0-255, actual AVL = AVL + 1 (so that we wont use 9 bits)
///////////////////////////////////////////////////////////////////////////
