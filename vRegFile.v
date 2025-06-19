module vRegFile (
    input clk,
    input rst,

    input [4:0] raA, raB, wa,      // Read addresses A/B, write address
    input [127:0] wd,              // Write data
    input wen,                     // Write enable for vector registers

    input [8:0] vl_in,             // New value for vl
    input vl_wen,                  // Write-enable for vl

    input [6:0] vtype_in,          // New value for vtype
    input vtype_wen,               // Write-enable for vtype

    output [127:0] rdA, rdB,       // Read data outputs
    output reg [8:0] vl,           // Current vl
    output reg [6:0] vtype         // Current vtype
);

    reg [127:0] data[31:0]; // 32 general-purpose vector registers
    integer i;

    // Write and reset logic
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (i = 0; i < 32; i = i + 1)
                data[i] <= 128'd0;
            vl <= 9'd0;
            vtype <= 7'd0;
        end else begin
            
            if (wen)
                data[wa] <= wd;
            else 
                data[wa] <= data[wa]; // Maintain current value if not writing

            if (vl_wen)
                vl <= vl_in;
            else
                vl <= vl; // Maintain current value if not writing

            if (vtype_wen)
                vtype <= vtype_in;
            else
                vtype <= vtype; // Maintain current value if not writing

        end
    end

    // Read ports with bypassing
    assign rdA = (wen && wa == raA) ? wd : data[raA];
    assign rdB = (wen && wa == raB) ? wd : data[raB];

endmodule
