`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2025 04:57:21 PM
// Design Name: 
// Module Name: mux4x1
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


module mux4x1(input [3:0] i,input [1:0] s,output o);
wire x1,x2;
mux2x1 m0(.a(i[0]),.b(i[1]),.s(s[0]),.o(x1));
mux2x1 m1(.a(i[2]),.b(i[3]),.s(s[0]),.o(x2));
mux2x1 m3(.a(x1),.b(x2),.s(s[1]),.o(o));
endmodule
