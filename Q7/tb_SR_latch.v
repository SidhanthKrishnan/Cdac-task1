`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2025 03:57:06 PM
// Design Name: 
// Module Name: tb_SR_latch
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


module tb_SR_LATCH();
  reg s, r, e;
  wire q, q_bar;
  reg [3:0] vec;
  SR_LATCH uut (
    .s(s),
    .r(r),
    .e(e),
    .q(q),
    .q_bar(q_bar)
  );

  initial begin
    for (vec = 4'b0000; vec <= 4'b0111; vec = vec + 1) begin
      {e,s,r}=vec[2:0];
    #10;
    end
    $finish;
  end
endmodule
