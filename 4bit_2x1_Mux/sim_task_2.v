`timescale 1ns / 1ps

module sim_task_2;

    reg  [3:0] a, b;
    reg        s;
    wire [3:0] out;

    mux_4_bit_2x1 dut(a, b, s, out);

    initial begin
        $monitor("s=%b, a=%b, b=%b, out=%b", s, a, b, out);

        a = 4'b0011;
        b = 4'b1100;

        s = 0; #10;   // out should be 0011
        s = 1; #10;   // out should be 1100

        a = 4'b1010;
        b = 4'b0101;

        s = 0; #10;   // out should be 1010
        s = 1; #10;   // out should be 0101

        $finish;
    end

endmodule
