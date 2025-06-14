`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2025 05:38:28 PM
// Design Name: 
// Module Name: tb_sr_ff
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


module tb_sr_ff();
reg clk;
reg s,r;
wire q,q_bar;
SR_ff uut(.clk(clk),.q(q),.s(s),.r(r),.q_bar(q_bar));
initial begin
clk=0;
s=0;r=0;
#10; s=0;r=1;
#10; s=1;r=0;
#10; s=0;r=0;
#10 $finish;
end

always begin
#5;
clk=~clk;
end

endmodule
