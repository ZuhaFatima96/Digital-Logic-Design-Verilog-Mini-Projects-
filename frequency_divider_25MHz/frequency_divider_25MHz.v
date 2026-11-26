module freq_divider_25mhz (
    input clk_100mhz,
    input rst,

    output clk_25mhz
);

    reg [1:0] counter;


    always @(posedge clk_100mhz or posedge rst)
    begin

        if (rst)
        begin
            counter <= 2'b00;
        end

        else
        begin
            counter <= counter + 1'b1;
        end

    end


    assign clk_25mhz = counter[1];

endmodule