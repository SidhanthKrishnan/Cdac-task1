`timescale 1ns / 1ps
module universal_shift_register(input [1:0] sel, input [3:0] d, input clk, input reset, output reg [3:0] q);
  always @(posedge clk or posedge reset) begin
    if (reset) q <= 0;
    else case (sel)
      2'b00: q <= q;
      2'b01: q <= {q[2:0], d[0]};
      2'b10: q <= {d[3], q[3:1]};
      2'b11: q <= d;
    endcase
  end
endmodule
