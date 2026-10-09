`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2026 17:55:35
// Design Name: 
// Module Name: uart_top_tb
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


module uart_top_tb(
  );
  reg clk,rst;
  reg wr_en;
  reg [7:0] data_in;
  reg rdy_clr;
  
  wire rdy;
  wire busy;
  wire [7:0] data_out;
  
  uart_top TB(.clk(clk),.rst(rst),.rdy_clr(rdy_clr),.wr_en(wr_en),.data_in(data_in),.rdy(rdy), .busy(busy),.data_out(data_out));
  
  initial 
  begin
  {clk,rst,data_in,rdy_clr}=0;
  end
  
  always #5 clk = ~clk;
  
  task send_byte(input [7:0]din);
  begin
    @(negedge clk)
    data_in = din;
    wr_en =1'b1;
    @(negedge clk);
    wr_en =1'b0;
    end
  endtask
  
  task clear_rdy;
  begin
    @(negedge clk);
    rdy_clr = 1'b1;
    @(negedge clk);
    rdy_clr = 1'b0;
    end
    endtask
    
    initial 
    begin
        @(negedge clk);
        rst=1'b1;
        @(negedge clk);
        rst=1'b0; 
        
        send_byte(8'd88);
        wait(busy);
        wait(!busy);
        wait(rdy);
        $display("The received data is =%h",data_out);
        clear_rdy;
        
        send_byte(8'd29);
        wait(busy);
        wait(!busy);
        wait(rdy);
        $display("The received data is =%h",data_out);
        clear_rdy;
        
        send_byte(8'd18);
        wait(busy);
        wait(!busy);
        wait(rdy);
        $display("The received data is =%h",data_out);
        clear_rdy;
        
        send_byte(8'd33);
        wait(busy);
        wait(!busy);
        wait(rdy);
        $display("The received data is =%h",data_out);
        clear_rdy;
        
        send_byte(8'd59);
        wait(busy);
        wait(!busy);
        wait(rdy);
        $display("The received data is =%h",data_out);
        clear_rdy;
        
        send_byte(8'd73);
        wait(busy);
        wait(!busy);
        wait(rdy);
        $display("The received data is =%h",data_out);
        clear_rdy;
        
        send_byte(8'd93);
        wait(busy);
        wait(!busy);
        wait(rdy);
        $display("The received data is =%h",data_out);
        clear_rdy;
        end
endmodule
