`timescale 1ns / 1ps

module mux_2x1(
    input  wire a, b, s,
    output wire out
    );

    wire a_i, b_i;

    assign a_i = a & ~s;
    assign b_i = b & s;

    assign out = a_i | b_i;

endmodule