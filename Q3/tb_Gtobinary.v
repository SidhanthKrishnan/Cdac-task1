`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2025 06:28:18 PM
// Design Name: 
// Module Name: tb_Gtobinary
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


module tb_GtoBinary();
reg [3:0] g;
wire [3:0]b;
GtoBinary uut(.g(g),.b(b));
initial 
begin
g=4'b0000;
repeat(16)begin
#10;
g=g+4'b0001;
end
#10 $finish;
end
endmodule
