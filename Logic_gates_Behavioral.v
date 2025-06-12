`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2025 03:50:48 PM
// Design Name: 
// Module Name: Logic_gates_Behavioral
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

module Logic_gates_Behavioral(a,b,o1,o2,o3,o4,o5,o6,o7);
input a,b;
output o1,o2,o3,o4,o5,o6,o7;
reg o1,o2,o3,o4,o5,o6,o7;
always@(*) begin
o1=a&&b;
o2=a||b;
o3=~(a&&b);
o4=~(a||b);
o5=a^b;
o6=~(a^b);
o7=~a;
end
endmodule
