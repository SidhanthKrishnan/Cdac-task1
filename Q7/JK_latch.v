`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2025 04:04:09 PM
// Design Name: 
// Module Name: JK_latch
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


module JK_latch(input j,input k,input e,output reg q,output q_bar);
assign q_bar=~q;
always@(*)begin

if(e)begin

if({j,k}==2'b01) q=0;
if({j,k}==2'b10) q=1;
if({j,k}==2'b11) q=~q;

end

end
endmodule
