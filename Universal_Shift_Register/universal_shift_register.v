`timescale 1ns / 1ps
module universal_shift_register (
    input clk,
    input rst,

    input [1:0] select,

    input shift_right_in,
    input shift_left_in,

    input [3:0] parallel_in,

    output reg [3:0] q
);

    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            q <= 4'b0000;
        end

        else
        begin
            case (select)

                // Hold
                2'b00:
                    q <= q;

                // Shift Right
                2'b01:
                    q <= {shift_right_in, q[3:1]};

                // Shift Left
                2'b10:
                    q <= {q[2:0], shift_left_in};

                // Parallel Load
                2'b11:
                    q <= parallel_in;

            endcase
        end
    end

endmodule