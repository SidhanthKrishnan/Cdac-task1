`timescale 1ns / 1ps
module T_ff(input t, input clk, input pr, input cr, output reg q, output q_bar);
  assign q_bar = ~q;

  always @(posedge clk or posedge pr or posedge cr) begin
    if (cr)
      q <= 0;
    else if (pr)
      q <= 1;
    else if (t)
      q <= ~q;
  end
endmodule