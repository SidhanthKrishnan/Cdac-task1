`timescale 1ns / 1ps
module serial_adder_mealy(
  input clk, rst, a_bit, b_bit,
  output reg sum, carry_out
);
  reg carry;

  always @(posedge clk or posedge rst) begin
    if (rst)
      carry <= 0;
    else begin
      sum <= a_bit ^ b_bit ^ carry;
      carry <= (a_bit & b_bit) | (a_bit & carry) | (b_bit & carry);
    end
  end

  always @(*) begin
    carry_out = carry;
  end
endmodule

