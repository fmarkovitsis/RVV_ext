module vs_selector (
    input high,
    input [1:0] offset,
    input [63:0] vs_data_in,
    
    output reg [31:0] vs_data_out,
    output reg [3:0] byte_select_vector
);

    always @(*) begin
        if(high) begin
            if (offset == 2'b00) begin
                vs_data_out = vs_data_in[63:32];
                byte_select_vector = 4'b1111; // Select all bytes for word store
            end
            else begin
                vs_data_out = 32'h69696969; // Invalid offset for word store
                byte_select_vector = 4'b1111; // Select all bytes for word store
            end
        end
        else begin
            if (offset == 2'b00) begin
                vs_data_out = vs_data_in[31:0];
                byte_select_vector = 4'b1111; // Select all bytes for word store
            end
            else begin
                vs_data_out = 32'h69696969; // Invalid offset for word store
                byte_select_vector = 4'b1111; // Select all bytes for word store
            end
        end
    end

endmodule