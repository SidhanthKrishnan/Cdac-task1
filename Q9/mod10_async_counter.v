`timescale 1ns / 1ps
module mod10_async_counter(input clk, input reset, output [3:0] count);
  wire [3:0] q;
  T_ff t0(.t(1), .clk(clk), .pr(1), .cr(reset), .q(q[0]), .q_bar());
  T_ff t1(.t(1), .clk(q[0]), .pr(1), .cr(reset), .q(q[1]), .q_bar());
  T_ff t2(.t(1), .clk(q[1]), .pr(1), .cr(reset), .q(q[2]), .q_bar());
  T_ff t3(.t(1), .clk(q[2]), .pr(1), .cr(reset), .q(q[3]), .q_bar());
  assign count = (q > 9) ? 0 : q;
endmodule
