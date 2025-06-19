module tb;
  reg [4:0] raA, raB, wa;
  reg [127:0] wd;
  reg wen;

  reg [8:0] vl_in;
  reg vl_wen;

  reg [6:0] vtype_in;
  reg vtype_wen;

  wire [127:0] rdA, rdB;
  wire [8:0] vl;
