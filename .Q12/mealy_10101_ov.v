`timescale 1ns / 1ps
module mealy_10101_ov(input clk, input rst, input in, output reg out);
  reg [2:0] state, next;
  parameter S0=0, S1=1, S2=2, S3=3, S4=4;
  always @(posedge clk or posedge rst) begin
    if (rst) state <= S0;
    else state <= next;
  end
  always @(*) begin
    out = 0;
    case (state)
      S0: next = in ? S1 : S0;
      S1: next = in ? S1 : S2;
      S2: next = in ? S3 : S0;
      S3: next = in ? S4 : S2;
      S4: begin next = in ? S1 : S0; out = ~in; end
    endcase
  end
endmodule