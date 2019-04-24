`timescale 1ns / 1ps

module lotTracker
(
    input clk,
    input rst,

    input SD1,
    input SD2,

    output err,
    output [3:0] count
);

logic inc, dec;

carDetector detector(.clk(clk), .rst(rst), .SD1(SD1), .SD2(SD2), .inc(inc), .dec(dec));
carCounter counter(.clk(clk), .rst(rst), .inc(inc), .dec(dec), .err(err), .count(count));

endmodule