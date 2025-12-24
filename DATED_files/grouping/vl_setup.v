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

    input[6:0] SEW;
    input[3:0] lmul;
    input[7:0] AVL;
    input valid_lmul;
    input valid_sew;

    output vsetup_en;
    output reg [7:0] vl;
    output reg [7:0]  new_AVL;

    reg [7:0] curr_vlmax;
    reg [2:0] temp;

    parameter [6:0] VLEN = 8'd64; 
    integer i;


    assign vsetup_en = valid_sew && valid_lmul;

    always @(*) begin
        case (SEW)
            8'd4: begin
                temp = 3'd2;
            end
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
            default: begin
                temp = 3'd0;
            end
        endcase
        
        curr_vlmax = (VLEN >> temp) * lmul;


        if (valid_lmul && valid_sew) begin
            if (curr_vlmax <= AVL) begin   /// may need to add stall mechanism there
                    vl = curr_vlmax;
                    new_AVL = AVL - curr_vlmax;
            end
            else begin
                vl = AVL;
                new_AVL = 9'd0;
            end
        end
        else begin // to avoid latches
            vl = 9'd0;
            new_AVL = 9'd0;
        end
    end

endmodule

//new problem: they cannot be encoded! in reallity,
//current_vlmax = (vlen/sew)*lmul

///////////////////////////////////////////////////////////////////////////
// sew:
// 000 -> 4
// 001 -> 8
// 010 -> 16
// 011 -> 32
// 100 -> 64

// lmul:
// 000 -> 1
// 001 -> 2
// 010 -> 4
// 011 -> 8
// 100 -> 16

// AVL -> max = 256
//        8 bits, 0-255, actual AVL = AVL + 1 (so that we wont use 9 bits)
///////////////////////////////////////////////////////////////////////////