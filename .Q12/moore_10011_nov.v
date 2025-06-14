`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/15/2025 02:18:22 AM
// Design Name: 
// Module Name: moore_10011_nov
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module moore_10011_nov(input clk, input rst, input in, output reg out);
  reg [2:0] state, next;
  parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5;
  always @(posedge clk or posedge rst) begin
    if (rst) state <= S0;
    else state <= next;
  end
  always @(*) begin
    case (state)
      S0: next = in ? S1 : S0;
      S1: next = in ? S1 : S2;
      S2: next = in ? S3 : S0;
      S3: next = in ? S1 : S4;
      S4: next = in ? S5 : S0;
      S5: next = in ? S0 : S0;
    endcase
  end
  always @(*) begin
    out = (state == S5);
  end
endmodule