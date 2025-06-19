module vpu_testbench;
  // Inputs
  reg [127:0] reg_in1;
  reg [127:0] reg_in2;
  reg [127:0] reg_scalar_in;
  reg [2:0]   valu_op;
  reg [7:0]   SEW;  // element width in bits: 8, 16, 32, 128

  // Output
  wire [127:0] reg_dest;

  // Instantiate the VPU
  vALU alu1(
    .reg_dest       (reg_dest),
    .reg_in1        (reg_in1),
    .reg_in2        (reg_in2),
    .reg_scalar_in  (reg_scalar_in),
    .valu_op        (valu_op),
    .SEW            (SEW)
  );

  integer i, j;
  initial begin
    //----------------------------------------------
    // Scenario 1: Incrementing / Decrementing vectors
    //----------------------------------------------
    // reg_in1 = 0x00,0x01,...0x0F; reg_in2 = 0xFF,0xFE,...0xF0
    for (i = 0; i < 16; i=i+1) begin
      reg_in1[i*8 +: 8] = i;
      reg_in2[i*8 +: 8] = 8'hFF - i;
    end
    reg_scalar_in = 0;
    // test all widths & opcodes
    for (i = 0; i < 4; i=i+1) begin
      SEW = 8<<i;
      for (valu_op = 0; valu_op < 4; valu_op = valu_op + 2) begin
        #1;
        $display("S1 SEW=%0d OP=%0b IN1=0x%h IN2=0x%h OUT=0x%h", SEW, valu_op, reg_in1, reg_in2, reg_dest);
      end
    end

    //----------------------------------------------
    // Scenario 2: Alternating patterns / overflow check
    //----------------------------------------------
    for (i = 0; i < 16; i=i+1) begin
      reg_in1[i*8 +: 8] = (i % 2) ? 8'hAA : 8'h55;
      reg_in2[i*8 +: 8] = 8'h80;
    end
    reg_scalar_in = 0;
    for (i = 0; i < 4; i=i+1) begin
      SEW = 8<<i;
      for (valu_op = 0; valu_op < 4; valu_op = valu_op + 2) begin
        #1;
        $display("S2 SEW=%0d OP=%0b IN1=0x%h IN2=0x%h OUT=0x%h", SEW, valu_op, reg_in1, reg_in2, reg_dest);
      end
    end

    //----------------------------------------------
    // Scenario 3: Signed
    //----------------------------------------------
    SEW = 8; reg_in1 = 128'h7F0180FF000000000000000000000000; reg_in2 = 128'h0100FF01000000000000000000000000;
    for (valu_op = 0; valu_op < 4; valu_op = valu_op + 1) begin
        
        #1
        $display("S2 SEW=%0d OP=%0b IN1=0x%h IN2=0x%h OUT=0x%h", SEW, valu_op, reg_in1, reg_in2, reg_dest);  
    end

    
    //----------------------------------------------
    // Scenario 4: Vector + Scalar
    //----------------------------------------------
    reg_in1 = 128'h0123456789ABCDEF0123456789ABCDEF;
    reg_scalar_in = 128'h0000000000000000000000000000007F;
    for (i = 0; i < 4; i=i+1) begin
      SEW = 8<<i;
      for (valu_op = 1; valu_op < 4; valu_op = valu_op + 2) begin
        #1;
        $display("S2 SEW=%0d OP=%0b IN1=0x%h IN2=0x%h OUT=0x%h", SEW, valu_op, reg_in1, reg_in2, reg_dest);
      end
    end

    reg_scalar_in = 128'h00000000000000000000000000001234;
    for (i = 0; i < 4; i=i+1) begin
      SEW = 8<<i;
      for (valu_op = 1; valu_op < 4; valu_op = valu_op + 2) begin
        #1;
        $display("S2 SEW=%0d OP=%0b IN1=0x%h IN2=0x%h OUT=0x%h", SEW, valu_op, reg_in1, reg_in2, reg_dest);
      end
    end

    reg_scalar_in = 128'h00000000000000000000000089ABCDEF;
    for (i = 0; i < 4; i=i+1) begin
      SEW = 8<<i;
      for (valu_op = 1; valu_op < 4; valu_op = valu_op + 2) begin
        #1;
        $display("S2 SEW=%0d OP=%0b IN1=0x%h IN2=0x%h OUT=0x%h", SEW, valu_op, reg_in1, reg_in2, reg_dest);
      end
    end
    

    //----------------------------------------------
    // Scenario 5: Edge case testing Vector + Scalar
    //----------------------------------------------

    reg_in1 = 128'h00FF7F8001FE0F10F0F1AA5500FF7F80;
    reg_scalar_in = 128'h0000000000000000000000000000007F;
    for (i = 0; i < 4; i=i+1) begin
      SEW = 8<<i;
      for (valu_op = 1; valu_op < 4; valu_op = valu_op + 2) begin
        #1;
        $display("S2 SEW=%0d OP=%0b IN1=0x%h IN2=0x%h OUT=0x%h", SEW, valu_op, reg_in1, reg_in2, reg_dest);
      end
    end

    reg_scalar_in = 128'h00000000000000000000000000001234;
    for (i = 0; i < 4; i=i+1) begin
      SEW = 8<<i;
      for (valu_op = 1; valu_op < 4; valu_op = valu_op + 2) begin
        #1;
        $display("S2 SEW=%0d OP=%0b IN1=0x%h IN2=0x%h OUT=0x%h", SEW, valu_op, reg_in1, reg_in2, reg_dest);
      end
    end

    reg_scalar_in = 128'h00000000000000000000000089ABCDEF;
    for (i = 0; i < 4; i=i+1) begin
      SEW = 8<<i;
      for (valu_op = 1; valu_op < 4; valu_op = valu_op + 2) begin
        #1;
        $display("S2 SEW=%0d OP=%0b IN1=0x%h IN2=0x%h OUT=0x%h", SEW, valu_op, reg_in1, reg_in2, reg_dest);
      end
    end
    
    //----------------------------------------------
    // Scenario 6: Multiplication
    //----------------------------------------------

    
    reg_in1 = 128'h0102_0304_0506_0708_090A_0B0C_0D0E_0F10;
    reg_in2 = 128'h100F_0E0D_0C0B_0A09_0807_0605_0403_0201;
    valu_op = 4;

    for (i = 0; i < 4; i=i+1) begin
        SEW = 8<<i;
        #1;
        $display("S2 SEW=%0d OP=%0b IN1=0x%h IN2=0x%h OUT=0x%h", SEW, valu_op, reg_in1, reg_in2, reg_dest);
    end

    //----------------------------------------------
    // Scenario 7: Multiplication with Scalar 
    //----------------------------------------------

    //----------------------------------------------
    // Scenario 8: Min 
    //----------------------------------------------

    reg_in1 = 128'hCF9B_7887_FFFF_AABB_

    $finish;
  end
endmodule