`timescale 1ns / 1ps

module mux_4x1_behav(
input wire a, b, c, d, s1, s2,
output reg o
);

    always @(*)begin

    if (s1==0 && s2==0) o = a;
    else if (s1==0 && s2==1) o = b;
    else if (s1==1 && s2==0) o = c;
    else                     o = d;
    
    end
endmodule

