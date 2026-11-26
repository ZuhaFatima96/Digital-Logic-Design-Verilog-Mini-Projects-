`timescale 1ns/1ps

module tb_reg8;

  reg        clk = 0;
  reg        rst;
  reg  [1:0] ctrl;
  reg        s_in;
  wire       s_out;
  wire [7:0] q;

  
  lab2_task1 dut (
    .clk(clk), .rst(rst), .ctrl(ctrl),
    .s_in(s_in), .s_out(s_out), .q(q)
  );

 
  always #5 clk = ~clk;

  always @(posedge clk)
    #1 $display("t=%0d ns  rst=%b  ctrl=%b  s_in=%b  q=%b  s_out=%b",
                $time, rst, ctrl, s_in, q, s_out);

  initial begin
    // Reset
    rst = 1; ctrl = 2'b00; s_in = 0;
    #20 rst = 0;

   
    ctrl = 2'b00;
    s_in = 1; #10;
    s_in = 0; #10;
    s_in = 1; #10;
    s_in = 1; #10;
    s_in = 0; #10;
    s_in = 0; #10;
    s_in = 1; #10;
    s_in = 0; #10;
    if (q == 8'b01001101) $display("PASS: pattern shifted in, q = %b", q);
    else                  $display("FAIL: expected 01001101, got %b", q);

  
    ctrl = 2'b10; s_in = 1;       
    #80;
    if (q == 8'b01001101) $display("PASS: 8 rotations right, q = %b", q);
    else                  $display("FAIL: expected 01001101, got %b", q);

    ctrl = 2'b11;
    #20;
    if (q == 8'b00110101) $display("PASS: 2 rotations left, q = %b", q);
    else                  $display("FAIL: expected 00110101, got %b", q);


    ctrl = 2'b01; s_in = 1;
    #40;
    if (q == 8'b01011111) $display("PASS: 4 shifts left, q = %b", q);
    else                  $display("FAIL: expected 01011111, got %b", q);

    rst = 1; #1;
    if (q == 8'b0) $display("PASS: reset cleared q");
    else           $display("FAIL: reset did not clear q");
    #9 rst = 0;

    #20 $finish;
  end

endmodule