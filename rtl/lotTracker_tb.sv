`timescale 1ns / 1ps

module lotTracker_tb();

logic clk = 0;
logic rst = 1;
logic SD1, SD2, err;
logic [3:0] count;

lotTracker dut(.*);

always begin
    #5
    clk = ~clk;
end

initial begin
    SD1 = 1;
    SD2 = 1;
    repeat(2) @(posedge clk);
    rst = 0;

    repeat(17) begin
        repeat(2) @(posedge clk);
        carEnter(clk, SD1, SD2);
    end
    repeat(10) @(posedge clk);

    repeat(17) begin
        repeat(2) @(posedge clk);
        carExit(clk, SD1, SD2);
    end
end

task automatic carEnter(ref logic clk, SD1, SD2);
    SD1 = 0;
    repeat(4) @(posedge clk);
    SD2 = 0;
    repeat(4) @(posedge clk);
    SD1 = 1;
    repeat(4) @(posedge clk);
    SD2 = 1;
endtask

task automatic carExit(ref logic clk, SD1, SD2);
    SD2 = 0;
    repeat(4) @(posedge clk);
    SD1 = 0;
    repeat(4) @(posedge clk);
    SD2 = 1;
    repeat(4) @(posedge clk);
    SD1 = 1;
endtask

endmodule