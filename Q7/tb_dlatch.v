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
  D_latch uut (
    .d(d),
    .e(e),
    .q(q),
    .q_bar(q_bar)
  );

  initial begin
    for({e,d}=2'b00;{e,d}<=2'b11;{e,d}={e,d}+2'b01)begin
    #10;
    end
   $finish;
  end
endmodule
