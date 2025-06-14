`timescale 1ns / 1ps
module tb_mod10_async_counter();
  reg clk;
  reg r;
  wire [3:0] count;

  mod10_async_counter uut(.clk1(clk), .r(r), .count(count));

  initial begin
    clk = 0;
    r = 0; #5;
    r = 1;
    #200;
    $finish;
  end

  always #5 clk = ~clk;
endmodule
