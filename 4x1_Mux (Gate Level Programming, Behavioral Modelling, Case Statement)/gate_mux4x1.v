`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module gate_mux4x1(
input wire a, b, c, d, s1, s2,
output wire o
    );
wire ns1, ns2;
wire w1,w2,w3,w4;

not n1(ns1, s1);
not n2(ns2, s2);

and a1(w1, a, ns1, ns2);
and a2(w2, b, ns1, s2);
and a3(w3, c, s1, ns2);
and a4(w4, d, s1, s2);

or o1(o, w1, w2, w3, w4);
 
endmodule
