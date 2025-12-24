// `ifndef TESTBENCH
`include "constants.vh"
`include "config.vh"
// `else
// `include "../includes/constants.vh"
// `include "../includes/config.vh"
// `endif

module sign_ext_64 (
    input   [4:0]   simm5,
    input   [31:0]  scalar_in,

    output  [63:0]  simm64,
    output  [63:0]  scalar_in_64
);

assign simm64		= { {59{{simm5[4]}}}, simm5 };
assign scalar_in_64 = { {32{{scalar_in[31]}}}, scalar_in};

endmodule