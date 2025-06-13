`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2025 06:22:39 PM
// Design Name: 
// Module Name: GtoBinary
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


module GtoBinary(input [3:0] g,output reg [3:0] b);
reg prev;
integer i;
always@(*)begin
prev=1'b0;
for(i=3;i>=0;i=i-1)begin
b[i]=prev^g[i];
prev=b[i];
end
end
endmodule
