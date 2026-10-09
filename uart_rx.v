`timescale 1ns /1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2026 14:02:02
// Design Name: 
// Module Name: uart_rx
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


module uart_rx(
    input clk,
    input rst,
    input rdy_clr,
    input en,
    input rx,
    output reg rdy,
    output reg [7:0] data_out
    );
    
    parameter start =2'b00;
    parameter data_st = 2'b01;
    parameter stop = 2'b10;
    
    reg [1:0]state;
    reg [3:0]ind=4'b0;
    reg [3:0]sample=4'b0;
    reg [7:0]temp = 8'b0;
    
    always@(posedge clk)
    begin
        if(rst)
            begin
                data_out<=0;
                state<= start;
                ind      <= 0;
                sample   <= 0;
                temp     <= 0;
            end
   
        else begin
         if(rdy_clr)
            rdy<=0;
         if(en)
         begin
         case(state)
         
         start: begin
                     if(rx==0)
                        sample<= sample+1;
                    if(sample == 4'd15)
                    begin
                        sample<=4'b0;
                        state <= data_st;
                        ind<=0;
                        temp<=0;
                    end
                  end
                    
         data_st: begin
                      sample<= sample+1;
                      if(sample==4'd8)
                      begin
                            temp[ind]<=rx;
                            ind<= ind+1;
                       end
                       
                       if(sample == 4'd15 && ind ==7)
                       begin
                            state<=stop;
                            sample <= 4'b0;
                            ind <= 3'b0;
                        end
                     end
                            
            stop:  begin
                       if(sample == 4'd15)
                       begin
                            state<=start;
                            sample<=0;
                            data_out<=temp;
                            rdy <=1;
                        end
                        else
                            sample<=sample+1;
                     end
                     
              default:  state <= start;
                     
              endcase
              end
            end
            end
endmodule
