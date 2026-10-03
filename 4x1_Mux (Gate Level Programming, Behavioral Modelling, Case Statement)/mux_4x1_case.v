`timescale 1ns / 1ps

module mux_4x1_case(
input wire a, b, c, d, s1, s2,
output reg o
    );
    
    always @(*)begin
    
        case({s1,s2})
            2'b00: o = a;
            2'b01: o = b;
            2'b10: o = c;
            2'b11: o = d;
        endcase
            
    end
    
endmodule
