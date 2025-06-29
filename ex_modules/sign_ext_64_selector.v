// `ifndef TESTBENCH
`include "constants.vh"
// `include "config.vh"
// `else
// `include "../includes/constants.vh"
// `include "../includes/config.vh"
// `endif

module sign_ext_64_selector (
    input       [1:0]   valu_src,
    input       [63:0]  simm64,
    input       [63:0]  scalar_in_64,
    input       [63:0]  rdvA,
    output reg  [63:0]  dataA_64
);

always @(*) begin
    case (valu_src)   //will probably need to add cases based on l/s
        2'b00: begin
            dataA_64 = rdvA;
        end
        2'b01: begin
            dataA_64 = scalar_in_64;
        end
        2'b10: begin
            dataA_64 = simm64;
        end
        default: begin
            dataA_64 = 64'b0;
        end
    endcase
end

endmodule