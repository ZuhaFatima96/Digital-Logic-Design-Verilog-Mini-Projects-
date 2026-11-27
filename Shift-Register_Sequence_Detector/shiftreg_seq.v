`timescale 1ns / 1ps
// ============================================================================
// Tutorial 4, Task 1, Part III: sequence detector from two 4-bit shift registers
//
// zeros_sr shifts in ~w : it reads 1111 after four consecutive 0s
// ones_sr  shifts in  w : it reads 1111 after four consecutive 1s
// z = 1 when either register has all bits set.
//
// Both registers share the button clock and the synchronous, active-low
// reset (reset clears both to 0000, meaning "nothing seen yet").
//
// Ports (same as Parts I and II, so the same XDC works):
//   SW[0] = resetn, SW[1] = w, BTNC = clock
//   LED[3:0] = zeros_sr, LED[7:4] = ones_sr, LED[8] = 0, LED[9] = z
//
// Add this one file to the project: it holds both modules.
// ============================================================================

// ---- 4-bit serial-in, parallel-out shift register ------------------------
module shift_reg4 (
    input            clk,
    input            resetn,   // synchronous, active low: clears to 0000
    input            din,      // serial input, enters at q[0]
    output reg [3:0] q         // q[3] = oldest bit, q[0] = newest bit
);
    always @(posedge clk) begin
        if (!resetn) q <= 4'b0000;
        else         q <= {q[2:0], din};   // shift left by one, din comes in at q[0]
    end
endmodule

// ---- Top module ----------------------------------------------------------
module part3_shiftreg (
    input  [1:0] SW,
    input        BTNC,
    output [9:0] LED
);
    wire resetn = SW[0];
    wire w      = SW[1];
    wire clk    = BTNC;

    wire [3:0] zeros;   // last four values of ~w
    wire [3:0] ones;    // last four values of  w
    wire       z;

    shift_reg4 zeros_sr (.clk(clk), .resetn(resetn), .din(~w), .q(zeros));
    shift_reg4 ones_sr  (.clk(clk), .resetn(resetn), .din( w), .q(ones));

    // All four bits set in either register. Same as (&zeros) | (&ones).
    assign z = (zeros[3] & zeros[2] & zeros[1] & zeros[0])
             | (ones[3]  & ones[2]  & ones[1]  & ones[0]);

    assign LED[3:0] = zeros;
    assign LED[7:4] = ones;
    assign LED[8]   = 1'b0;
    assign LED[9]   = z;
endmodule
