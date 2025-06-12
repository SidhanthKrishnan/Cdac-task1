`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2025 06:02:27 PM
// Design Name: 
// Module Name: mux13x1
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


module mux13x1(input [12:0] i, input [3:0] s, output o);
    wire [7:0] w1;
    wire [3:0] w2;
    wire [1:0] w3;
    wire dummy0 = 1'b0;
    wire dummy1 = 1'b0;
    wire dummy2 = 1'b0;

    mux2x1 m0 (.a(i[0]),  .b(i[1]),     .s(s[0]), .o(w1[0]));
    mux2x1 m1 (.a(i[2]),  .b(i[3]),     .s(s[0]), .o(w1[1]));
    mux2x1 m2 (.a(i[4]),  .b(i[5]),     .s(s[0]), .o(w1[2]));
    mux2x1 m3 (.a(i[6]),  .b(i[7]),     .s(s[0]), .o(w1[3]));
    mux2x1 m4 (.a(i[8]),  .b(i[9]),     .s(s[0]), .o(w1[4]));
    mux2x1 m5 (.a(i[10]), .b(i[11]),    .s(s[0]), .o(w1[5]));
    mux2x1 m6 (.a(i[12]), .b(dummy0),   .s(s[0]), .o(w1[6]));
    mux2x1 m7 (.a(dummy1),.b(dummy2),   .s(s[0]), .o(w1[7]));

    mux2x1 m8  (.a(w1[0]), .b(w1[1]), .s(s[1]), .o(w2[0]));
    mux2x1 m9  (.a(w1[2]), .b(w1[3]), .s(s[1]), .o(w2[1]));
    mux2x1 m10 (.a(w1[4]), .b(w1[5]), .s(s[1]), .o(w2[2]));
    mux2x1 m11 (.a(w1[6]), .b(w1[7]), .s(s[1]), .o(w2[3]));

    mux2x1 m12 (.a(w2[0]), .b(w2[1]), .s(s[2]), .o(w3[0]));
    mux2x1 m13 (.a(w2[2]), .b(w2[3]), .s(s[2]), .o(w3[1]));

    mux2x1 m14 (.a(w3[0]), .b(w3[1]), .s(s[3]), .o(o));
endmodule

