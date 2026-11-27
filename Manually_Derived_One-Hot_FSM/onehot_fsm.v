`timescale 1ns / 1ps
// ============================================================================
// Tutorial 4, Task 1, Part I: manually derived one-hot FSM (Table 1 codes)
//
// z = 1 after four consecutive 0s or four consecutive 1s on w.
// Overlapping runs are allowed: five equal inputs give z = 1 twice.
//
// Ports (Nexys A7):
//   SW[0]    active-low synchronous reset (SW0 down = reset)
//   SW[1]    w
//   BTNC     clock, one press = one step
//   LED[8:0] state flip-flops y8..y0
//   LED[9]   z
//
// Table 1 codes, one flip-flop per state:
//   A = y0, B = y1, C = y2, D = y3, E = y4, F = y5, G = y6, H = y7, I = y8
//
// Rules followed for this part:
//   * the D-input logic uses continuous assign statements only (no if, no case)
//   * the nine state flip-flops are in one always block clocked by BTNC
// ============================================================================
module part1_onehot (
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
    // One-hot: each flip-flop's input is the OR of the arrows entering its
    // state, each arrow ANDed with the w value written on it.
    assign Y[0] = 1'b0;                                      // A: no arrow enters A (reset only)
    assign Y[1] = ~w & (y[0] | y[5] | y[6] | y[7] | y[8]);   // B: w=0 from A, F, G, H, I
    assign Y[2] = ~w & y[1];                                 // C: w=0 from B
    assign Y[3] = ~w & y[2];                                 // D: w=0 from C
    assign Y[4] = ~w & (y[3] | y[4]);                        // E: w=0 from D, E
    assign Y[5] =  w & (y[0] | y[1] | y[2] | y[3] | y[4]);   // F: w=1 from A, B, C, D, E
    assign Y[6] =  w & y[5];                                 // G: w=1 from F
    assign Y[7] =  w & y[6];                                 // H: w=1 from G
    assign Y[8] =  w & (y[7] | y[8]);                        // I: w=1 from H, I

    // ---- Output (Moore machine): z = 1 in E or I -----------------------
    assign z = y[4] | y[8];

    // ---- Synchronous, active-low reset at the D inputs -----------------
    // resetn = 0: the next press loads A = 000000001 (y0 set, y8..y1 cleared).
    // resetn = 1: D = Y.
    // Same behaviour as "if (!resetn) y <= 9'b000000001; else y <= Y;"
    // but written with gates, so this part contains no if statement.
    assign D[0]   = Y[0] | ~resetn;
    assign D[8:1] = Y[8:1] & {8{resetn}};   // {8{resetn}} is resetn copied to 8 bits

    // ---- Nine state flip-flops, clocked by the button ------------------
    always @(posedge clk)
        y <= D;

    assign LED[8:0] = y;
    assign LED[9]   = z;
endmodule
