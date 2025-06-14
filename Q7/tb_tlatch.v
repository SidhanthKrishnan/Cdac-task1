`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2025 04:38:14 PM
// Design Name: 
// Module Name: tb_tlatch
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


module tb_tlatch();
  reg t, e;
  wire q, q_bar;
  reg [2:0] vec;
  T_latch uut (
    .t(t),
    .e(e),
    .q(q),
    .q_bar(q_bar)
  );

  initial begin
    for (vec = 3'b000; vec <= 3'b011; vec = vec + 1) begin
      {e,t}=vec[1:0];
    #10;
    end
   $finish;
  end
endmodule
