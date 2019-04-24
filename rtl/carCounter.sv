`timescale 1ns / 1ps

module carCounter
(
    input logic clk,
    input logic rst,

    input logic inc,
    input logic dec,

    output logic err,
    output logic [3:0] count
);

logic currError, nextError;
logic [3:0] currCount, nextCount;

always_ff @(posedge clk) begin
    if(rst) begin
        currError <= 0;
        currCount <= 0;
    end
    else begin
        currError <= nextError;
        currCount <= nextCount;
    end
end

always_comb begin
    if(inc == 1) begin
        if(currCount == 4'b1111) begin
            nextError = 1;
            nextCount = currCount;
        end
        else begin
            nextError = currError;
            nextCount = currCount + 1;
        end
    end
    else if(dec == 1) begin
        if(currCount == 4'b0000) begin
            nextError = 1;
            nextCount = currCount;
        end
        else begin
            nextError = currError;
            nextCount = currCount - 1;
        end
    end
    else begin
        nextError = currError;
        nextCount = currCount;
    end
end

assign err = currError;
assign count = currCount;

endmodule