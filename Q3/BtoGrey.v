`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2025 06:01:58 PM
// Design Name: 
// Module Name: BtoGrey
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


module BtoGrey(input [3:0]b,output reg [3:0]g);
reg prev;
integer i;
always@(*)begin
prev=1'b0;
for(i=3;i>=0;i=i-1)begin
g[i]=b[i]^prev;
prev=b[i];
end
end
endmodule
