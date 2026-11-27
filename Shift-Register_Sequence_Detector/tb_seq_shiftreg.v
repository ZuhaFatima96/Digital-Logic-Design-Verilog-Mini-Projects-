`timescale 1ns / 1ps

module tb_part3_shiftreg;

    reg [1:0] SW;
    reg BTNC;
    wire [9:0] LED;
    integer errors = 0;

    part3_shiftreg dut (.SW(SW), .BTNC(BTNC), .LED(LED));

    // Check both registers, output z, and the unused LED.
    task check;
        input [3:0] expected_zeros;
        input [3:0] expected_ones;
        input expected_z;
        begin
            if (LED !== {expected_z, 1'b0, expected_ones, expected_zeros}) begin
                errors = errors + 1;
                $display("FAIL at %0t: expected %b, got %b",
                         $time,
                         {expected_z, 1'b0, expected_ones, expected_zeros},
                         LED);
            end
        end
    endtask

    // Set the input, press the button, and check the result.
    task step;
        input w;
        input [3:0] expected_zeros;
        input [3:0] expected_ones;
        input expected_z;
        begin
            SW[1] = w;
            #5 BTNC = 1;
            #5 BTNC = 0;
            check(expected_zeros, expected_ones, expected_z);
        end
    endtask

    initial begin
        SW = 2'b00;
        BTNC = 0;

        // Reset: both registers should be cleared.
        step(0, 4'b0000, 4'b0000, 0);
        SW[0] = 1;

        // Four zeros, followed by an extra zero.
        step(0, 4'b0001, 4'b0000, 0);
        step(0, 4'b0011, 4'b0000, 0);
        step(0, 4'b0111, 4'b0000, 0);
        step(0, 4'b1111, 4'b0000, 1);
        step(0, 4'b1111, 4'b0000, 1);

        // Change to ones: z clears, then rises after four ones.
        step(1, 4'b1110, 4'b0001, 0);
        step(1, 4'b1100, 4'b0011, 0);
        step(1, 4'b1000, 4'b0111, 0);
        step(1, 4'b0000, 4'b1111, 1);
        step(1, 4'b0000, 4'b1111, 1);

        // Reset should only take effect on a clock edge.
        SW[0] = 0;
        #5 check(4'b0000, 4'b1111, 1);
        step(1, 4'b0000, 4'b0000, 0);
        SW[0] = 1;

        // Check operation after reset and an input change.
        step(1, 4'b0000, 4'b0001, 0);
        step(0, 4'b0001, 4'b0010, 0);

        if (errors == 0)
            $display("PASS: all checks passed");
        else
            $display("FAIL: %0d errors", errors);

        $finish;
    end

endmodule
