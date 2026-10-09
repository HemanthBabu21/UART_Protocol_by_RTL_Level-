`timescale 1ns /1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2026 17:21:30
// Design Name: 
// Module Name: uart_top
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


module uart_top(
    input clk,
    input rst,
    input rdy_clr,
    input wr_en,
    input [7:0] data_in,
    output rdy,
    output busy,
    output [7:0] data_out
    );
    
    wire tx_clk_en;
    wire rx_clk_en;
    
    wire tx_temp;
    
    Baud_gen baud(.clk(clk),.rst(rst),.tx_en(tx_clk_en),.rx_en(rx_clk_en));
    uart_tx TX(.clk(clk),.rst(rst),.wr_en(wr_en),.en(tx_clk_en),.data_in(data_in),.tx(tx_temp),.busy(busy));
    uart_rx RX(.clk(clk),.rst(rst),.rdy_clr(rdy_clr),.en(rx_clk_en),.rx(tx_temp),.rdy(rdy),.data_out(data_out));
    
endmodule
