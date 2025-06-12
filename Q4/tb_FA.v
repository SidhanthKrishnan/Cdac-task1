`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2025 01:51:36 AM
// Design Name: 
// Module Name: tb_FA
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


module tb_FA();
reg [3:0] a;
wire s,cout;
FA uut(.a(a[0]),.b(a[1]),.cin(a[2]),.s(s),.cout(cout));
initial begin
for(a=3'b000;a!=3'b111;a=a+3'b001)begin
#10;
end
#10;
$finish;
end
endmodule
