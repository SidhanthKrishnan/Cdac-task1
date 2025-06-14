`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2025 05:43:04 PM
// Design Name: 
// Module Name: tb_d_ff
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


module tb_d_ff();
  reg clk, d;
  wire q, q_bar;
  D_ff uut(.d(d), .clk(clk), .q(q), .q_bar(q_bar));
  initial begin
  clk=0;
    d = 0; #10;
    d = 1; #10;
    d = 0; #10;
    d = 1; #10;
    $finish;
  end
  always #5 clk = ~clk;
endmodule
