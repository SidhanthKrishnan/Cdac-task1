`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2025 05:58:50 PM
// Design Name: 
// Module Name: mux7x1
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


module mux7x1(input [6:0] i, input [2:0] s, output o);
    wire [3:0] w1;
    wire [1:0] w2;
    wire dummy = 1'b0;
    mux2x1 m0 (.a(i[0]), .b(i[1]), .s(s[0]), .o(w1[0]));
    mux2x1 m1 (.a(i[2]), .b(i[3]), .s(s[0]), .o(w1[1]));
    mux2x1 m2 (.a(i[4]), .b(i[5]), .s(s[0]), .o(w1[2]));
    mux2x1 m3 (.a(i[6]), .b(dummy), .s(s[0]), .o(w1[3]));
    mux2x1 m4 (.a(w1[0]), .b(w1[1]), .s(s[1]), .o(w2[0]));
    mux2x1 m5 (.a(w1[2]), .b(w1[3]), .s(s[1]), .o(w2[1]));
    mux2x1 m6 (.a(w2[0]), .b(w2[1]), .s(s[2]), .o(o));
endmodule

