`timescale 1ns / 1ps

module mux_4_bit_2x1(
    input  wire [3:0] a, b,
    input  wire       s,
    output wire [3:0] out
    );

    mux_2x1 mux1 (.a(a[0]), .b(b[0]), .s(s), .out(out[0]));
    mux_2x1 mux2 (.a(a[1]), .b(b[1]), .s(s), .out(out[1]));
    mux_2x1 mux3 (.a(a[2]), .b(b[2]), .s(s), .out(out[2]));
    mux_2x1 mux4 (.a(a[3]), .b(b[3]), .s(s), .out(out[3]));

endmodule