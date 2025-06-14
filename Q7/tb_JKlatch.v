`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2025 04:09:34 PM
// Design Name: 
// Module Name: tb_JKlatch
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


module tb_JK_latch();
  reg j, k, e;
  wire q, q_bar;
  reg [3:0] vec;
  JK_latch uut (
    .j(j),
    .k(k),
    .e(e),
    .q(q),
    .q_bar(q_bar)
  );
  initial begin
    for (vec = 4'b0000; vec <= 4'b0111; vec = vec + 1) begin
      {e, j, k} = vec[2:0];
      #10;
    end
    $finish;
  end
endmodule

