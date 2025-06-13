`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2025 10:36:07 PM
// Design Name: 
// Module Name: tb_priorityencoder
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


module tb_priorityencoder();
reg [3:0] i;
wire [1:0] o;
priority_encoder uut(.i(i),.o(o));
initial
begin
i=4'b0000;
repeat(16)
begin
#10;
i=i+1;

end
$finish;

end
endmodule
