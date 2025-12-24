`ifndef TESTBENCH
`include "constants.vh"
`include "config.vh"
`else
`include "../includes/constants.vh"
`include "../includes/config.vh"
`endif

module vRegFile (
    input clk,
    input rst,

    input [4:0] raA, raB, wa,      // Read addresses A/B, write address
    input [63:0] wd,              // Write data
    input wen,                     // Write enable for vector registers

    input [6:0] vl_in,             // New value for vl                  // Write-enable for vl
    input [6:0] AVL_in,            // New value for AVL
    input [6:0] vtype_in,          // New value for vtype

    output [63:0] rdA, rdB,       // Read data outputs
    output reg [6:0] vl,           // Current vl
    output reg [6:0] vtype,        // Current vtype
    output reg [6:0] AVL_reg
);

    reg [63:0] data[31:0]; // 32 general-purpose vector registers
    integer i;

    // Write and reset logic
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (i = 0; i < 32; i = i + 1)
                data[i] <= 64'd0;
            vl <= 7'd0;
            vtype <= 7'd0;
        end else begin
            if (wen)
                data[wa] <= wd;
            else 
                data[wa] <= data[wa]; // Maintain current value if not writing

            if (vtype_in[6]) begin // valid vtype bit 
                vl <= vl_in;
                vtype <= vtype_in;
                AVL_reg <= AVL_in;
            end else begin
                vl <= vl; // Maintain current value if not writing
                vtype <= vtype; // Maintain current value if not writing
                AVL_reg <= AVL_reg;
            end
        end
    end

    // Read ports with bypassing
    assign rdA = (wen && wa == raA) ? wd : data[raA];
    assign rdB = (wen && wa == raB) ? wd : data[raB];

endmodule