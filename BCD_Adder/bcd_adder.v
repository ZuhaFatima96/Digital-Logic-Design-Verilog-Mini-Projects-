`timescale 1ns / 1ps
module bcd_adder (
    input      [3:0] a,
    input      [3:0] b,
    output     [3:0] units,
    output           tens
);
    wire [4:0] sum;
    wire [4:0] adjusted;
 
    assign sum      = a + b;
    assign tens     = (sum > 5'd9);
    assign adjusted = tens ? (sum - 5'd10) : sum;
    assign units    = adjusted[3:0];
endmodule
