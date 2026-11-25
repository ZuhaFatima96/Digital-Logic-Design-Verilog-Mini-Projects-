`timescale 1ns / 1ps
module bcd_adder_top (
    input  [7:0] SW,
    output [6:0] SEG,
    output [7:0] AN,
    output       DP,
    output       LED
);
    wire [3:0] units;
 
    bcd_adder   add (.a(SW[3:0]), .b(SW[7:4]), .units(units), .tens(LED));
    bcd_to_7seg dec (.bcd(units), .seg(SEG));
 
    assign AN = 8'b1111_1110;
    assign DP = 1'b1;
endmodule
