`timescale 1ns / 1ps

module sim_task1;
reg a, b, c, d, s1, s2;
wire o1, o2, o3;
integer i, j;

gate_mux4x1 m1(a, b, c, d, s1, s2, o1);
mux_4x1_behav m2(a, b, c, d, s1, s2, o2);
mux_4x1_case m3(a, b, c, d, s1, s2, o3);

initial begin
    $monitor("abcd= %b%b%b%b, s1s2 = %b%b, o1o2o3= %b%b%b",
              a, b, c, d, s1, s2, o1, o2, o3);

    a = 1; b = 0; c = 1; d = 0;
    s1 = 0; s2 = 0; #10;
    s1 = 0; s2 = 1; #10;
    s1 = 1; s2 = 0; #10;
    s1 = 1; s2 = 1; #10;

    a = 0; b = 1; c = 0; d = 1;
    s1 = 0; s2 = 0; #10;
    s1 = 0; s2 = 1; #10;
    s1 = 1; s2 = 0; #10;
    s1 = 1; s2 = 1; #10;

    $finish;
end 
endmodule
