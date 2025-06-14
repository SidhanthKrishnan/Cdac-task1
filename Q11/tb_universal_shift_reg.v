`timescale 1ns / 1ps
module tb_universal_shift_register();
  reg [1:0] sel;
  reg [3:0] d;
  reg clk, reset;
  wire [3:0] q;
  universal_shift_register uut(.sel(sel), .d(d), .clk(clk), .reset(reset), .q(q));
  initial begin
    clk = 0; reset = 1; #5;
    reset = 0; sel = 2'b11; d = 4'b1010; #10;
    sel = 2'b01; d = 4'b0001; #10;
    sel = 2'b10; #10;
    sel = 2'b00; #10;
    $finish;
  end
  always #5 clk = ~clk;
endmodule