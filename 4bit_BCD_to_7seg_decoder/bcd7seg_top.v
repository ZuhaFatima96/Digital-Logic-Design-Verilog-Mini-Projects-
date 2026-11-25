`timescale 1ns / 1ps

module bcd7seg_top(

    input  [3:0] SW,
    output [6:0] SEG,
    output [7:0] AN,
    output       DP
);
    bcd_to_7seg dec (.bcd(SW), .seg(SEG));
 
    assign AN = 8'b1111_1110;
    assign DP = 1'b1;

endmodule
