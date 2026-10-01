`timescale 1ns / 1ps

module part2(
    input  wire [9:0] SW,
    output wire [9:0] LEDR
    );

    wire [3:0] M;               // internal wire, not visible outside part2

    mux_4_bit_2x1 mux_4bit (
        .a   (SW[3:0]),         // X input
        .b   (SW[7:4]),         // Y input
        .s   (SW[9]),           // select
        .out (M)
    );

    assign LEDR[3:0] = M;       // multiplexer output
    assign LEDR[5:4] = 2'b00;   // unused lights held off
    assign LEDR[9:6] = SW[7:4]; // show the Y input

endmodule