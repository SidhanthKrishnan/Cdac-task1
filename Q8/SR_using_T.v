`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2025 09:59:57 PM
// Design Name: 
// Module Name: SR_using_T
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


module SR_using_T(input s,input clk,input r,input pr,input cr,output q,output q_bar);

T_ff t0(.t((s&q_bar)|(r&q)),.clk(clk),.pr(pr),.cr(cr),.q(q),.q_bar(q_bar));
endmodule
