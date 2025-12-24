`ifndef TESTBENCH
`include "constants.vh"
`include "config.vh"
`else
`include "../includes/constants.vh"
`include "../includes/config.vh"
`endif

module vcontrol_unit (
    output reg vRegWrite,
    output reg [3:0] valu_op,
    output reg valu_src,
    output reg grouping_enable,
    output reg high,
    output reg vmemw_en,

    input [2:0] funct3,
    input [5:0] funct6,
    input [6:0] opcode
);
    always @(*) begin
        case (opcode)
            `VR_FORMAT: begin
                high = 1'b0;
                vmemw_en = 1'b0;
                case (funct3)
                    `VV_FORMAT: begin
                        valu_src = 1'b0;
                        vRegWrite = 1'b1;
                        grouping_enable = 1'b1;
                        case (funct6)
                            `VADD: begin
                                valu_op = 4'b0;
                            end 
                            `VSUB: begin
                                valu_op = 4'b0010;
                            end
                            `VMUL: begin
                                valu_op = 4'b0100;
                            end
                            `VAND: begin
                                valu_op = 4'b0110;
                            end
                            `VOR: begin
                                valu_op = 4'b1000;
                            end
                            `VXOR: begin
                                valu_op = 4'b1010;
                            end
                            default: begin
                                valu_op = 4'b1111;
                            end
                        endcase
                    end 
                    `VX_FORMAT: begin
                        valu_src = 1'b0;
                        vRegWrite = 1'b1;
                        grouping_enable = 1'b1;
                        case (funct6)
                            `VADD: begin
                                valu_op = 4'b0001;
                            end 
                            `VSUB: begin
                                valu_op = 4'b0011;
                            end
                            `VMUL: begin
                                valu_op = 4'b0101;
                            end
                            `VAND: begin
                                valu_op = 4'b0111;
                            end
                            `VOR: begin
                                valu_op = 4'b1001;
                            end
                            `VXOR: begin
                                valu_op = 4'b1011;
                            end
                            default: begin
                                valu_op = 4'b1111;
                            end
                        endcase
                    end
                    `VI_FORMAT: begin
                        valu_src = 1'b1;
                        vRegWrite = 1'b1;
                        grouping_enable = 1'b1;
                        case (funct6)
                            `VADD: begin
                                valu_op = 4'b0001;
                            end 
                            `VSUB: begin
                                valu_op = 4'b0011;
                            end
                            `VMUL: begin
                                valu_op = 4'b0101;
                            end
                            `VAND: begin
                                valu_op = 4'b0111;
                            end
                            `VOR: begin
                                valu_op = 4'b1001;
                            end
                            `VXOR: begin
                                valu_op = 4'b1011;
                            end
                            default: begin
                                valu_op = 4'b1111;
                            end
                        endcase
                    end
                    `VC_FORMAT: begin
                        valu_src = 1'b0;
                        vRegWrite = 1'b0;
                        valu_op = 4'b1111;
                        grouping_enable = 1'b0;
                    end
                    default: begin
                        valu_src = 1'b0;
                        vRegWrite = 1'b0;
                        valu_op = 4'b1111;
                        grouping_enable = 1'b0;
                    end
                endcase
            end
            `VS_FORMAT: begin
                vmemw_en = 1'b1;
                valu_src = 1'b0;
                vRegWrite = 1'b0;
                valu_op = 4'b1111;
                grouping_enable = 1'b0;
                case (funct3)
                    `VSW: begin //used for high
                        high = 1'b1;
                    end
                    `VSH: begin
                        high = 1'b0;
                    end
                    default: begin
                        high = 1'b0;
                    end
                endcase

            end
            default: begin
                vmemw_en = 1'b0;
                high = 1'b0;
                valu_src = 1'b0;
                vRegWrite = 1'b0;
                valu_op = 4'b1111;
                grouping_enable = 1'b0;
            end
        endcase
    end
endmodule