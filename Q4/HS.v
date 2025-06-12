`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2025 02:00:45 AM
// Design Name: 
// Module Name: HS
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


module HS(a, b, d, b_out);
  input a, b;
  output d, b_out;

  assign d = a ^ b;   
  assign b_out = ~a & b;   
endmodule
