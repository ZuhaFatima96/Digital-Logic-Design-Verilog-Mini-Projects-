`timescale 1ns / 1ps
`timescale 1ns / 1ps
 
module tb_bcd_7seg;
 
    reg  [3:0] bcd;
    wire [6:0] seg;
    reg  [6:0] expected [0:9];
    integer i, errors;
 
    bcd_to_7seg dut (.bcd(bcd), .seg(seg));
 
    initial begin
        expected[0] = 7'b0000001;
        expected[1] = 7'b1001111;
        expected[2] = 7'b0010010;
        expected[3] = 7'b0000110;
        expected[4] = 7'b1001100;
        expected[5] = 7'b0100100;
        expected[6] = 7'b0100000;
        expected[7] = 7'b0001111;
        expected[8] = 7'b0000000;
        expected[9] = 7'b0000100;
 
        errors = 0;
        for (i = 0; i <= 9; i = i + 1) begin
            bcd = i[3:0];
            #10;
            $display("bcd=%b  digit=%0d  abcdefg=%b", bcd, i, seg);
            if (seg !== expected[i]) begin
                errors = errors + 1;
                $display("  FAIL expected %b", expected[i]);
            end
        end
 
        bcd = 4'b1111;
        #10;
        $display("invalid input %b -> %b (blank)", bcd, seg);
        $display("seg: %0d errors out of 10", errors);
        $finish;
    end
endmodule

