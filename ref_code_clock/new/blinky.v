`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2026 05:11:10 PM
// Design Name: 
// Module Name: blinky
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module blinky (clk, rst, out_led);
    input wire clk, rst;
    output reg out_led;
    
    wire clk_1hz, clk_1khz;
    reg   clk_1hz_d;
    
    clock_divider CD (.rst(rst), .clk_in(clk), .clk_out_1hz(clk_1hz), .clk_out_1khz(clk_1khz));
    
    always @(posedge clk) begin
        if (rst) begin
            out_led <= 0;
            clk_1hz_d <= 0;
        end
        else begin
            clk_1hz_d <= clk_1hz; // --> edge detecter on 1hz clock
            if (clk_1hz & ~clk_1hz_d)
                out_led <= ~out_led;
        end
    end
    
endmodule
