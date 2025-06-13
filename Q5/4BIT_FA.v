`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2025 12:59:48 PM
// Design Name: 
// Module Name: 4BIT_FA
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


module fourBIT_FA(input [3:0]a,input [3:0] b,input cin,output[3:0] o,output cout);
assign {cout,o}=a+b+cin;
endmodule
