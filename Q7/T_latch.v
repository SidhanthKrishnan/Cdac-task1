`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2025 04:36:29 PM
// Design Name: 
// Module Name: T_latch
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


module T_latch(input t,input e,output q,output q_bar);
JK_latch m0(.j(t),.k(t),.e(e),.q(q),.q_bar(q_bar));
endmodule
