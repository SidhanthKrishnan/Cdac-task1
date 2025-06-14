`timescale 1ns / 1ps
module tb_mod10_sync_counter();
  reg clk, reset;
  wire [3:0] count;
  mod10_sync_counter uut(.clk(clk), .reset(reset), .count(count));
  initial begin
    clk = 0; reset = 1; #5;
    reset = 0; #100;
    $finish;
  end
  always #5 clk = ~clk;
endmodule