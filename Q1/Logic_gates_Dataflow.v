`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2025 03:28:11 PM
// Design Name: 
// Module Name: Logic_gates_Dataflow
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
// this the my task 1 where i will do the following:-
// use a and b as inputs and output are as following:-
//o1-> and of a and b
//o2-> or of a and b
//o3-> nand of a and b
//o4-> nor of a and b
//o5-> xor of a and b
//o6-> xnor of a and b
//o7-> not of a

module Logic_gates_Dataflow(a,b,o1,o2,o3,o4,o5,o6,o7,o8);
input a,b;
output o1,o2,o3,o4,o5,o6,o7,o8;
assign o1=a&&b;
assign o2=a||b;
assign o3=~(a&&b);
assign o4=~(a||b);
assign o5=a^b;
assign o6=~(a^b);
assign o7=~a;
assign o8=~b;
endmodule
