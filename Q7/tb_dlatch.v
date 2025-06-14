`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2025 03:43:14 PM
// Design Name: 
// Module Name: tb_dlatch
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


module tb_D_latch();
  reg d, e;
  wire q, q_bar;
  reg [2:0] vec;
  D_latch uut (
    .d(d),
    .e(e),
    .q(q),
    .q_bar(q_bar)
  );

  initial begin
    for (vec = 3'b000; vec <= 3'b011; vec = vec + 1) begin
      {e,d}=vec[1:0];
    #10;
    end
   $finish;
  end
endmodule
