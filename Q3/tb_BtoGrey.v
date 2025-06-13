`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2025 06:15:10 PM
// Design Name: 
// Module Name: tb_BtoGrey
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


module tb_BtoGrey();
reg [3:0] b;
wire [3:0]g;
BtoGrey uut(.b(b),.g(g));
initial 
begin
b=4'b0000;
repeat(16)begin
#10;
b=b+4'b0001;
end
#10 $finish;
end
endmodule
