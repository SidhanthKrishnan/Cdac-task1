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
  SR_LATCH uut (
    .s(s),
    .r(r),
    .e(e),
    .q(q),
    .q_bar(q_bar)
  );

  initial begin
    for({e,s,r}=3'b000;{e,s,r}<=3'b111;{e,s,r}={e,s,r}+3'b001)begin
    #10;
    end
    $finish;
  end
endmodule
