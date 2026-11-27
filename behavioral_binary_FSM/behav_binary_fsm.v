`timescale 1ns / 1ps
// ============================================================================
// Tutorial 4, Task 1, Part II: behavioural FSM with a case statement
//
// Same FSM as Part I, written over the 4-bit binary codes of Table 3.
// The synthesis tool derives the gates. Structure follows Figure 3:
//   always block 1 (combinational): state table, case over y_Q
//   always block 2 (clocked)      : state register, synchronous reset
//   assign                        : output z
//
// Ports (same as Part I, so the same XDC works):
//   SW[0] = Resetn (active low), SW[1] = w, BTNC = Clock
//   LED[3:0] = 4-bit state code y3..y0, LED[9] = z, LED[8:4] = 0
// ============================================================================
module part2_binary (
    input  [1:0] SW,
    input        BTNC,
    output [9:0] LED
);
    wire Resetn = SW[0];
    wire w      = SW[1];
    wire Clock  = BTNC;

    // y_Q = present state, Y_D = next state.
    // fsm_encoding = "none" tells Vivado not to re-encode this register,
    // so the Table 3 codes below are kept exactly.
    // (Step 8: change "none" to "one_hot" and re-run synthesis.)
    (* fsm_encoding = "none" *) reg [3:0] y_Q;
    reg [3:0] Y_D;
    wire      z;

    // Table 3 binary codes
    parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100,
              F = 4'b0101, G = 4'b0110, H = 4'b0111, I = 4'b1000;

    // ---- State table (combinational) ------------------------------------
    always @(w, y_Q)
    begin: state_table
        case (y_Q)
            A: if (!w) Y_D = B; else Y_D = F;
            B: if (!w) Y_D = C; else Y_D = F;
            C: if (!w) Y_D = D; else Y_D = F;
            D: if (!w) Y_D = E; else Y_D = F;
            E: if (!w) Y_D = E; else Y_D = F;   // run of 0s continues: stay in E
            F: if (!w) Y_D = B; else Y_D = G;
            G: if (!w) Y_D = B; else Y_D = H;
            H: if (!w) Y_D = B; else Y_D = I;
            I: if (!w) Y_D = B; else Y_D = I;   // run of 1s continues: stay in I
            default: Y_D = 4'bxxxx;             // codes 1001..1111 are never used
        endcase
    end // state_table

    // ---- State flip-flops, synchronous active-low reset -----------------
    always @(posedge Clock)
    begin: state_FFs
        if (!Resetn) y_Q <= A;
        else         y_Q <= Y_D;
    end // state_FFs

    // ---- Output (Moore): z = 1 in E or I ----------------------------------
    assign z = (y_Q == E) | (y_Q == I);

    // ---- LEDs -------------------------------------------------------------
    assign LED[3:0] = y_Q;
    assign LED[8:4] = 5'b00000;
    assign LED[9]   = z;
endmodule
