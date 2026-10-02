`timescale 1ns / 1ps

module sevenseg(
    input  wire [1:0] a,
    output wire [0:6] o,
    output wire [7:0] an,
    output wire       dp
);

    // a = 00 displays d
    // a = 01 displays E
    // a = 10 displays 1
    // a = 11 displays 0

    // Seven-segment decoder (active-low)
    assign o[0] = ~a[0];
    assign o[1] = ~a[1] & a[0];
    assign o[2] = ~a[1] & a[0];
    assign o[3] =  a[1] & ~a[0];
    assign o[4] =  a[1] & ~a[0];
    assign o[5] = ~a[0];
    assign o[6] =  a[1];

    // Enable only the rightmost seven-segment display
    assign an = 8'b11111110;

    // Turn decimal point off
    assign dp = 1'b1;

endmodule