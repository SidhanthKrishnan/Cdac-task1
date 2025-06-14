`timescale 1ns / 1ps

// 9. Mod-10 Synchronous Up-Counter
module mod10_sync_counter(input clk, input reset, output reg [3:0] count);
  always @(posedge clk or posedge reset) begin
    if (reset) count <= 0;
    else if (count == 9) count <= 0;
    else count <= count + 1;
  end
endmodule