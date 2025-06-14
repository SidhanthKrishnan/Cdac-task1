`timescale 1ns / 1ps
module tb_johnson_counter();
  reg clk, reset;
  wire [3:0] out;
  johnson_counter uut(.clk(clk), .reset(reset), .out(out));
  initial begin
    clk = 0; reset = 1; #5;
    reset = 0; #100;
    $finish;
  end
  always #5 clk = ~clk;
endmodule
