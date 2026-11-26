`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2026 03:57:25 PM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider (rst, clk_in, clk_out_1hz, clk_out_1khz);
    input wire clk_in, rst;
    output reg clk_out_1hz;
    output reg clk_out_1khz;
    
    // Constants defined
    localparam div_count1 = 26'd50000000;
    localparam div_count2 = 16'd50000;
    
    // Otput clock counters
    reg [25:0] count_1hz;
    reg [15:0] count_1khz;
    
    // 1 Hz output clock generation 
    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            count_1hz <= 0;
            clk_out_1hz <= 0;
        end
        else if (count_1hz == div_count1 - 1) begin
            count_1hz <= 'h0;
            clk_out_1hz <= ~clk_out_1hz;
        end
        else
            count_1hz <= count_1hz+1;
    end

    // 1 KHz output clock generation 
    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            count_1khz <= 0;
            clk_out_1khz <= 0;
        end
        else if (count_1khz == div_count2 - 1) begin
            count_1khz <= 'h0;
            clk_out_1khz <= ~clk_out_1khz;
        end
        else
        count_1khz <= count_1khz+1;
    end

    
endmodule
