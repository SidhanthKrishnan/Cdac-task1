`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2025 02:02:29 AM
// Design Name: 
// Module Name: FS
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


module FS(a, b, bin, d, bout);
  input a, b, bin;
  output d, bout;

  assign d = a ^ b ^ bin;                       
  assign bout = (~a & b) | ((~(a ^ b)) & bin);
endmodule
