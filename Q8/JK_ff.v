`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2025 05:12:42 PM
// Design Name: 
// Module Name: JK_ff
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


module JK_ff(input j,input k,input clk,output reg q,output q_bar);
assign q_bar=~q;
always@(posedge clk)begin
if({j,k}==2'b01) q<=0;
if({j,k}==2'b10) q<=1;
if({j,k}==2'b11) q<=~q;
end
endmodule
