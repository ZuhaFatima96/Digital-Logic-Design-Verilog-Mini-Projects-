`timescale 1ns/1ps

module freq_divider_25mhz_tb;

    reg clk_100mhz;
    reg rst;

    wire clk_25mhz;


    freq_divider_25mhz uut (
        .clk_100mhz(clk_100mhz),
        .rst(rst),
        .clk_25mhz(clk_25mhz)
    );


    // 100 MHz input clock
    initial
    begin
        clk_100mhz = 0;
        forever #5 clk_100mhz = ~clk_100mhz;
    end


    initial
    begin

        rst = 1;

        #20;

        rst = 0;


        #300;


        $finish;

    end

endmodule