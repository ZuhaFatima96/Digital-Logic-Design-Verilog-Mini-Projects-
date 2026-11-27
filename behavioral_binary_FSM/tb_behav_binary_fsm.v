`timescale 1ns / 1ps

module tb_part2_binary;

    reg [1:0] SW;
    reg BTNC;
    wire [9:0] LED;
    integer errors = 0;

    part2_binary dut (.SW(SW), .BTNC(BTNC), .LED(LED));

    localparam [3:0]
        A = 4'b0000, B = 4'b0001, C = 4'b0010,
        D = 4'b0011, E = 4'b0100, F = 4'b0101,
        G = 4'b0110, H = 4'b0111, I = 4'b1000;

    // Check the state LEDs, output z, and any unused LEDs.
    task check;
        input [3:0] expected_state;
        input expected_z;
        begin
            if (LED !== {expected_z, 5'b00000, expected_state}) begin
                errors = errors + 1;
                $display("FAIL at %0t: expected %b, got %b",
                         $time, {expected_z, 5'b00000, expected_state}, LED);
            end
        end
    endtask

    // Set the input, press the button, and check the result.
    task step;
        input w;
        input [3:0] expected_state;
        input expected_z;
        begin
            SW[1] = w;
            #5 BTNC = 1;
            #5 BTNC = 0;
            check(expected_state, expected_z);
        end
    endtask

    initial begin
        SW = 2'b00;
        BTNC = 0;

        // Reset, then release reset.
        step(0, A, 0);
        SW[0] = 1;

        // Four zeros, followed by an extra zero.
        step(0, B, 0);
        step(0, C, 0);
        step(0, D, 0);
        step(0, E, 1);
        step(0, E, 1);

        // Change to ones: z clears, then rises after four ones.
        step(1, F, 0);
        step(1, G, 0);
        step(1, H, 0);
        step(1, I, 1);
        step(1, I, 1);

        // Reset should only take effect on a clock edge.
        SW[0] = 0;
        #5 check(I, 1);
        step(1, A, 0);
        SW[0] = 1;

        // Check operation after reset and an input change.
        step(1, F, 0);
        step(0, B, 0);

        if (errors == 0)
            $display("PASS: all checks passed");
        else
            $display("FAIL: %0d errors", errors);

        $finish;
    end

endmodule
