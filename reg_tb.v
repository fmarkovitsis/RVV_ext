`timescale 10ns/10ns

module tb;
  reg clk;
  reg rst;
  
  reg [4:0] raA, raB, wa;
  reg [127:0] wd;
  reg wen;

  reg [8:0] vl_in;
  reg vl_wen;

  reg [6:0] vtype_in;
  reg vtype_wen;

  wire [127:0] rdA, rdB;
  wire [8:0] vl;

  vRegFile vrgfl (clk, rst, raA, raB, wa, wd, wen, vl_in, vl_wem, vtype_in, vtype_wen, rdA, rdB, vl, vtype);

  always
    #1  clk = ~clk;

    initial begin
      $dumpfile("tb.vcd");
      $dumpvars(0, tb);

      ra
