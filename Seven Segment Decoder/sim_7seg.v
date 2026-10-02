`timescale 1ns / 1ps

module sim_task3;

    reg  [1:0] a;
    wire [0:6] o;

    sevenseg dut(
        .a(a),
        .o(o)
    );

    initial begin
        a = 2'b00; #10;  // d
        a = 2'b01; #10;  // E
        a = 2'b10; #10;  // 1
        a = 2'b11; #10;  // 0

        $finish;
    end

endmodule