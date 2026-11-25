`timescale 1ns / 1ps
`timescale 1ns / 1ps
 
module bcd_adder_tb;
 
    reg  [3:0] a, b;
    wire [3:0] units;
    wire       tens;
    integer i, j, total, errors;
 
    bcd_adder dut (.a(a), .b(b), .units(units), .tens(tens));
 
    initial begin
        errors = 0;
        for (i = 0; i <= 9; i = i + 1) begin
            for (j = 0; j <= 9; j = j + 1) begin
                a = i[3:0];
                b = j[3:0];
                #10;
                total = i + j;
                if (units !== (total % 10) || tens !== (total / 10)) begin
                    errors = errors + 1;
                    $display("FAIL %0d + %0d = %0d, got tens=%b units=%0d",
                              i, j, total, tens, units);
                end
            end
        end
        a = 4'd7; b = 4'd8; #10;
        $display("7 + 8  -> tens=%b units=%0d", tens, units);
        a = 4'd9; b = 4'd9; #10;
        $display("9 + 9  -> tens=%b units=%0d", tens, units);
        $display("bcd adder: %0d errors out of 100", errors);
        $finish;
    end
endmodule

