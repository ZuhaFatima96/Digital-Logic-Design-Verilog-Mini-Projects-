`timescale 1ns / 1ps

module top_mux4x1(
input [5:0] SW ,
output [2:0] LED
    );   
    gate_mux4x1 m1(SW[0], SW[1], SW[2], SW[3], SW[4], SW[5], LED[0]);
    mux_4x1_behav m2(SW[0], SW[1], SW[2], SW[3], SW[4], SW[5], LED[1]);
    mux_4x1_case m3(SW[0], SW[1], SW[2], SW[3], SW[4], SW[5], LED[2]);
    
endmodule
