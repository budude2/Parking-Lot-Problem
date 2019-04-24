`timescale 1ns / 1ps

module carDetector
(
    input logic clk,
    input logic rst,
    input logic SD1,
    input logic SD2,

    output logic inc,
    output logic dec
);

typedef enum logic [8:0] {init = 9'h001, en1 = 9'h002, en2 = 9'h004, en3 = 9'h008, en4 = 9'h010, ex1 = 9'h020, ex2 = 9'h040, ex3 = 9'h080, ex4 = 9'h100} stateType;

stateType currState, nextState;

always_ff @(posedge clk) begin
    if(rst) begin
        currState <= init;
    end
    else begin
        currState <= nextState;
    end
end

always_comb begin
    nextState = currState;
    inc = 0;
    dec = 0;

    case(currState)
        init:
            begin
                if(SD1 == 1'b0) begin
                    nextState = en1;
                end
                else if(SD2 == 1'b0) begin
                    nextState = ex1;
                end
            end

        en1:
            begin
                if(SD1 == 1'b1) begin
                    nextState = init;
                end
                else if(SD2 == 1'b0) begin
                    nextState = en2;
                end
            end

        en2:
            begin
                if(SD2 == 1'b1) begin
                    nextState = init;
                end
                else if(SD1 == 1'b1) begin
                    nextState = en3;
                end
            end

        en3:
            begin
                if(SD1 == 1'b0) begin
                    nextState = init;
                end
                else if(SD2 == 1'b1) begin
                    nextState = en4;
                end
            end

        en4:
            begin
                inc = 1;
                nextState = init;
            end

        ex1:
            begin
                if(SD2 == 1'b1) begin
                    nextState = init;
                end
                else if(SD1 == 1'b0) begin
                    nextState = ex2;
                end
            end

        ex2:
            begin
                if(SD1 == 1'b1) begin
                    nextState = init;
                end
                else if(SD2 == 1'b1) begin
                    nextState = ex3;
                end
            end

        ex3:
            begin
                if(SD2 == 1'b0) begin
                    nextState = init;
                end
                else if(SD1 == 1'b1) begin
                    nextState = ex4;
                end
            end

        ex4:
            begin
                dec = 1;
                nextState = init;
            end
    endcase // currState
end

endmodule