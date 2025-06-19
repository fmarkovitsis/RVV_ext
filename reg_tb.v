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

      clk = 0;
      rst = 0;
      raA = 0; raB = 0; wa = 0;
      wd = 128'h0;
      wen = 0;
      vl_in = 9'd0;
      vl_wen = 0;
      vtype_in = 7'd0;
      vtype_wen = 0;
    
      #10 rst = 1; 
      #10;

      // Write at reg 5
      wa = 5;
      wd = 128'hDEADBEEF_DEADBEEF_DEADBEEF_DEADBEEF;
      wen = 1;
      #10 
      wen = 0;

      // Read from reg 5
      raA = 5;
      #10;
      $display("Read rdA: %h (expected DEADBEEF...)", rdA);

      // Write and read reg 6. (forwarding)
      wa = 6;
      wd = 128'h12345678_12345678_12345678_12345678;
      wen = 1;
      raA = 6;
      #10;
      $display("Bypass rdA (write and read same cycle): %h (expected 12345678...)", rdA);
      wen = 0;

      // Write extra regs
      vl_in = 9'd255;
      vl_wen = 1;
      vtype_in = 7'd42;
      vtype_wen = 1;
      #10;
      vl_wen = 0;
      vtype_wen = 0;
  
      // Read extra regs
      #10;
      $display("vl = %d (expected 255), vtype = %d (expected 42)", vl, vtype);
  
      // Read from reg 10
      raA = 10;
      #10;
      $display("Read rdA (unwritten reg 10): %h (expected 0)", rdA);

      $finish;
  end

endmodule
