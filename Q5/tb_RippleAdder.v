`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2025 01:31:03 PM
// Design Name: 
// Module Name: tb_RippleAdder
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


module tb_rippleadder();
reg [3:0]a;
reg [3:0]b;
reg cin;
wire [3:0]o;
wire cout;
rippleadder uut (.a(a),.b(b),.cin(cin),.o(o),.cout(cout));
initial begin
a=4'b0000;
cin=0;
for(b=4'b0000;b<=4'b1111;b=b+4'b0001)begin
#10;
end
end
endmodule
