
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2025 10:11:03 PM
// Design Name: 
// Module Name: tb_sr_using_t
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


`timescale 1ns / 1ps
module tb_sr_using_t();
  reg clk;
  reg s, r;
  reg pr, cr;
  wire q, q_bar;

  SR_using_T uut(
    .clk(clk),
    .s(s),
    .r(r),
    .pr(pr),
    .cr(cr),
    .q(q),
    .q_bar(q_bar)
  );

  initial begin
    clk = 0;
    pr = 1; cr = 0; #2; 
    cr = 1;
    s = 0; r = 0; #10;
    s = 0; r = 1; #10;
    s = 1; r = 0; #10;
    s = 0; r = 0; #10;
    $finish;
  end

  always #5 clk = ~clk;
endmodule
