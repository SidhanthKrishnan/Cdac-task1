`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2025 03:14:02 PM
// Design Name: 
// Module Name: Logic_gates_Gatelevel
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

module Logic_gates_Gatelevel(a,b,o1,o2,o3,o4,o5,o6,o7);
input a,b;
output o1,o2,o3,o4,o5,o6,o7;
and(o1,a,b);
or(o2,a,b);
nand(o3,a,b);
nor(o4,a,b);
xor(o5,a,b);
xnor(o6,a,b);
not(o7,a,b);
endmodule
