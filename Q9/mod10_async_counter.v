`timescale 1ns / 1ps

module T_ff1(input t, input clk, input pr, input cr, output reg q, output q_bar);
  assign q_bar = ~q;

  always @(negedge clk or negedge pr or negedge cr) begin
    if (!cr)
      q = 0;
    else if (!pr)
      q = 1;
    else if (t)
      q <= ~q;
  end
endmodule

module mod10_async_counter(input clk1, input r, output [3:0] count);
  wire [3:0] q;
  wire internal_reset;

  // Active-low reset (0 when q == 10)
  assign internal_reset = ~(q == 4'd10);  // 0 when we want to clear

  wire cr = r & internal_reset;  // final cr input to T_ff1

  T_ff1 t0(.t(1), .clk(clk1),   .pr(1), .cr(cr), .q(q[0]), .q_bar());
  T_ff1 t1(.t(1), .clk(q[0]),   .pr(1), .cr(cr), .q(q[1]), .q_bar());
  T_ff1 t2(.t(1), .clk(q[1]),   .pr(1), .cr(cr), .q(q[2]), .q_bar());
  T_ff1 t3(.t(1), .clk(q[2]),   .pr(1), .cr(cr), .q(q[3]), .q_bar());

  assign count = q;
endmodule
