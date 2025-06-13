`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2025 01:49:29 AM
// Design Name: 
// Module Name: FA
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


module FA(a,b,cin,s,cout);
input a,b,cin;
output s,cout;
wire s1,c,c1;
HA m0(.a(a),.b(b),.s(s1),.c(c));
HA m1(.a(s1),.b(cin),.s(s),.c(c1));
assign cout=c|c1;

endmodule
