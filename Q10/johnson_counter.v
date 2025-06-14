`timescale 1ns / 1ps
module johnson_counter(input clk, input reset, output reg [3:0] out);
  always @(posedge clk or posedge reset) begin
    if (reset) out <= 4'b0000;
    else out <= {~out[0], out[3:1]};
  end
endmodule
