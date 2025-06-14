`timescale 1ns / 1ps
module tb_serial_adder_moore();

  reg clk, rst, a_bit, b_bit;
  wire sum, carry_out;

  serial_adder_moore uut(
    .clk(clk),
    .rst(rst),
    .a_bit(a_bit),
    .b_bit(b_bit),
    .sum(sum),
    .carry_out(carry_out)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus
  initial begin
    rst = 1; #10;
    rst = 0;

    // Test input bits: A = 1011, B = 1101 (LSB first)
    a_bit = 1; b_bit = 1; #10;
    a_bit = 1; b_bit = 0; #10;
    a_bit = 0; b_bit = 1; #10;
    a_bit = 1; b_bit = 1; #10;

    $finish;
  end

endmodule
