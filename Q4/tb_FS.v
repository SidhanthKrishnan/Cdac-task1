`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2025 02:04:03 AM
// Design Name: 
// Module Name: tb_FS
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


module tb_FS();
  reg [2:0] in;
  wire d, bout;

  FS uut(.a(in[0]), .b(in[1]), .bin(in[2]), .d(d), .bout(bout));
  integer i;
  initial begin
    for (i = 0; i < 8; i = i + 1) begin
      in = i[2:0];
      #10;
    end
    $finish;
  end
endmodule
