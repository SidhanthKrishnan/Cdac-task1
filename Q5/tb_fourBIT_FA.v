`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2025 01:06:54 PM
// Design Name: 
// Module Name: tb_fourBIT_FA
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


module tb_fourBIT_FA();
reg [3:0]a;
reg [3:0]b;
reg cin;
wire [3:0]o;
wire cout;
fourBIT_FA uut (.a(a),.b(b),.cin(cin),.o(o),.cout(cout));
initial begin
a=4'b0000;
cin=0;
for(b=4'b0000;b<=4'b1111;b=b+4'b0001)begin
#10;
end
end
endmodule
