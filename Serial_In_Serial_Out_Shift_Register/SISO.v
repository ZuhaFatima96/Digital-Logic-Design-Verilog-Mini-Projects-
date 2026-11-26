`timescale 1ns / 1ps


module lab2_task1(
input clk, s_in, rst, 
input [1:0]ctrl,
output s_out,
output reg [7:0]q
    );
    
    wire clk_out_1hz, clk_out_1khz;
    clock_divider c1(rst, clk, clk_out_1hz, clk_out_1khz);
    
    always @(posedge clk_out_1hz or posedge rst)
    begin
    if (rst)
    q=0;
    else begin 
        case (ctrl)
        2'b00 : q <= {s_in, q[7:1]};  
        2'b01 : q <= {q[6:0], s_in};
        2'b10 : q <= {q[0], q[7:1]};
        2'b11 : q <= {q[6:0], q[7]}; 
        endcase
    end
    end
    assign s_out = ctrl[0]? q[7] : q[0] ;
endmodule
