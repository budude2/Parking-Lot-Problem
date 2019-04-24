`timescale 1ns / 1ps

module carCounter_tb();

logic clk = 0;
logic rst = 1;
logic inc, dec, err;
logic [3:0] count;

carCounter dut (.*);

always begin
    #5
    clk = ~clk;
end

initial begin
    inc = 0;
    dec = 0;
    repeat(2) @(posedge clk);
    rst = 0;
    inc = 1;
    repeat(20) @(posedge clk);
    inc = 0;
    dec = 1;
    repeat(20) @(posedge clk);
    dec = 0;
    rst = 1;
    repeat(2) @(posedge clk);
    rst = 0;
    dec = 1;
end

endmodule