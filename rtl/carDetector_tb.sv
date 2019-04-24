`timescale 1ns / 1ps

module carDetector_tb
(

);

logic clk = 0;
logic rst = 1;
logic SD1, SD2, inc, dec;

carDetector dut(.*);

always begin
    #5
    clk = ~clk;
end

initial begin
    SD1 = 1;
    SD2 = 1;
    repeat(2) @(posedge clk);
    rst = 0;

    // Entry test
    repeat(4) @(posedge clk);
    SD1 = 0;
    repeat(4) @(posedge clk);
    SD2 = 0;
    repeat(4) @(posedge clk);
    SD1 = 1;
    repeat(4) @(posedge clk);
    SD2 = 1;
    repeat(10) @(posedge clk);


    // Exit test
    SD2 = 0;
    repeat(4) @(posedge clk);
    SD1 = 0;
    repeat(4) @(posedge clk);
    SD2 = 1;
    repeat(4) @(posedge clk);
    SD1 = 1;
end

endmodule