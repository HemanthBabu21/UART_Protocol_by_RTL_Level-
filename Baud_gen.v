`timescale 1ns/ 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2026 13:12:22
// Design Name: 
// Module Name: Baud_gen
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


module Baud_gen #(
    parameter integer baud_rate = 9600,
    parameter integer freq      = 50000000
)(
    input  clk,
    input rst,
    output tx_en,
    output rx_en
);

  //  integer no_cy_rx = freq / baud_rate;
  //  integer no_cy    = freq / (baud_rate * 16);

integer no_cy_rx = 325;
integer no_cy = 5208;

    reg [15:0] tx_count;
    reg [15:0] rx_count;

    always @(posedge clk)
    begin
        if (rst)
            tx_count <= 0;
        else if (tx_count == no_cy-1)
            tx_count <= 0;
        else
            tx_count <= tx_count + 1;
    end

    always @(posedge clk)
    begin
        if (rst)
            rx_count <= 0;
        else if (rx_count == no_cy_rx-1)
            rx_count <= 0;
        else
            rx_count <= rx_count + 1;
    end

    assign tx_en = (tx_count == 0);
    assign rx_en = (rx_count == 0);

endmodule