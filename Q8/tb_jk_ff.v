`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2025 05:18:24 PM
// Design Name: 
// Module Name: tb_jk_ff
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


module tb_jk_ff();
reg clk;
reg j,k;
wire q,q_bar;
JK_ff uut(.clk(clk),.q(q),.j(j),.k(k),.q_bar(q_bar));
initial begin
clk=0;
j=0;k=0;
#10; j=0;k=1;
#10; j=1;k=0;
#10; j=0;k=0;
#10 $finish;
end

always begin
#5;
clk=~clk;
end

endmodule
