`timescale 1ns /1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2026 13:38:57
// Design Name: 
// Module Name: uart_tx
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_tx(
    input clk,
    input rst,
    input wr_en,
    input en,
    input [7:0] data_in,
    output reg tx,
    output busy
);

    parameter idle    = 2'b00;
    parameter start   = 2'b01;
    parameter data_st = 2'b10;
    parameter stop    = 2'b11;

    reg [1:0] state;
    reg [2:0] ind;
    reg [7:0] data;

    always @(posedge clk)
    begin
        if (rst)
        begin
            state <= idle;
            tx    <= 1'b1;
            ind   <= 3'b0;
            data  <= 8'b0;
        end
        else
        begin
            case(state)

                idle:
                begin
                    tx <= 1'b1;

                    if (wr_en)
                    begin
                        data  <= data_in;
                        ind   <= 3'b0;
                        state <= start;
                    end
                end

                start:
                begin
                    if (en)
                    begin
                        tx    <= 1'b0;       // Start bit
                        state <= data_st;
                    end
                end

                data_st:
                begin
                    if (en)
                    begin
                        tx <= data[ind];     // Send current bit

                        if (ind == 3'd7)
                        begin
                            ind   <= 3'b0;
                            state <= stop;
                        end
                        else
                        begin
                            ind <= ind + 1'b1;
                        end
                    end
                end

                stop:
                begin
                    if (en)
                    begin
                        tx    <= 1'b1;       // Stop bit
                        state <= idle;
                    end
                end

                default:
                begin
                    state <= idle;
                    tx    <= 1'b1;
                end

            endcase
        end
    end

    assign busy = (state != idle);

endmodule
