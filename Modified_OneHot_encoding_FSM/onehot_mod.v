`timescale 1ns / 1ps
// ============================================================================
// Tutorial 4, Task 1, Part I (second version): modified one-hot, Table 2 codes
//
// Table 2 codes:
//   A = 000000000
//   B = 000000011   C = 000000101   D = 000001001   E = 000010001
//   F = 000100001   G = 001000001   H = 010000001   I = 100000001
//
// States B..I keep their own bit (y1..y8), exactly as in Table 1.
// Only y0 changes meaning: it was "in A", now it is "NOT in A"
// (y0 = 1 in every state except A). So "in A" is now written ~y[0].
//
// Compared with part1_onehot.v only these lines change:
//   Y[0] : 0 becomes 1
//   Y[1] : y[0] becomes ~y[0]
//   Y[5] : y[0] becomes ~y[0]
//   reset: loads 000000000 instead of 000000001
//
// Same ports, same XDC as part1_onehot.v.
// ============================================================================
module part1_onehot_mod (
    input  [1:0] SW,
    input        BTNC,
    output [9:0] LED
);
    wire resetn = SW[0];   // 0 = reset
    wire w      = SW[1];
    wire clk    = BTNC;

    reg  [8:0] y;          // present state y8..y0
    wire [8:0] Y;          // next state, read off the state diagram
    wire [8:0] D;          // flip-flop D inputs (Y with the reset applied)
    wire       z;

    // ---- Next-state logic ----------------------------------------------
    assign Y[0] = 1'b1;                                       // CHANGED: next state is never A, and B..I all have y0 = 1
    assign Y[1] = ~w & (~y[0] | y[5] | y[6] | y[7] | y[8]);   // CHANGED: "in A" is now ~y0
    assign Y[2] = ~w & y[1];
    assign Y[3] = ~w & y[2];
    assign Y[4] = ~w & (y[3] | y[4]);
    assign Y[5] =  w & (~y[0] | y[1] | y[2] | y[3] | y[4]);   // CHANGED: "in A" is now ~y0
    assign Y[6] =  w & y[5];
    assign Y[7] =  w & y[6];
    assign Y[8] =  w & (y[7] | y[8]);

    // ---- Output: unchanged, E and I keep their bits --------------------
    assign z = y[4] | y[8];

    // ---- Synchronous, active-low reset at the D inputs -----------------
    // The reset code is all zeros, so reset simply clears every flip-flop.
    // Same behaviour as "if (!resetn) y <= 9'b000000000; else y <= Y;"
    assign D = Y & {9{resetn}};

    // ---- Nine state flip-flops, clocked by the button ------------------
    always @(posedge clk)
        y <= D;

    assign LED[8:0] = y;
    assign LED[9]   = z;
endmodule
