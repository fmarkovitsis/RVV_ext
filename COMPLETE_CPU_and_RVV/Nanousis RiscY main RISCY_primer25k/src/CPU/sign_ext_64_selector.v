`ifndef TESTBENCH
`include "constants.vh"
`include "config.vh"
`else
`include "../includes/constants.vh"
`include "../includes/config.vh"
`endif

module sign_ext_64_selector (
    input               valu_src,
    input       [63:0]  simm64,
    input       [63:0]  scalar_in_64,
    output reg  [63:0]  dataA_64
);

always @(*) begin
    case (valu_src)   //will probably need to add cases based on l/s
        1'b0: begin
            dataA_64 = scalar_in_64;
        end
        1'b1: begin
            dataA_64 = simm64;
        end
        default: begin
            dataA_64 = 64'b0;
        end
    endcase
end

endmodule