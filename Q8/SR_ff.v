`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2025 05:36:56 PM
// Design Name: 
// Module Name: SR_ff
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


module SR_ff(input s,input r,input clk,output reg q,output q_bar);
assign q_bar=~q;
always@(posedge clk)begin
if({s,r}==2'b01) q<=0;
if({s,r}==2'b10) q<=1;
if({s,r}==2'b11) q<=1'bx;
end
endmodule