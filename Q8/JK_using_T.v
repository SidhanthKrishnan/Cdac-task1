`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2025 10:21:04 PM
// Design Name: 
// Module Name: JK_using_T
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


module JK_using_T(input j,input k,input clk,input pr,input cr,output q,output q_bar);
wire t=(j & ~q) | (k & q);
T_ff t0(.t(t),.clk(clk),.pr(pr),.cr(cr),.q(q),.q_bar(q_bar));
endmodule
