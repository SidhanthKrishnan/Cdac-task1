`timescale 1ns / 1ps
module moore_10101_nov(
  input clk,
  input reset,
  input in,
  output reg out
);

  typedef enum reg [2:0] {
    S0, S1, S2, S3, S4, S5
  } state_t;

  state_t state, next_state;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= S0;
    else
      state <= next_state;
  end

  always @(*) begin
    case (state)
      S0: next_state = (in == 1) ? S1 : S0;
      S1: next_state = (in == 0) ? S2 : S1;
      S2: next_state = (in == 1) ? S3 : S0;
      S3: next_state = (in == 0) ? S4 : S1;
      S4: next_state = (in == 1) ? S5 : S0;
      S5: next_state = (in == 1) ? S1 : S0;
      default: next_state = S0;
    endcase
  end

  always @(*) begin
    out = (state == S5) ? 1 : 0;
  end
endmodule
