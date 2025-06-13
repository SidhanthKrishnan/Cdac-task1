`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2025 01:30:16 PM
// Design Name: 
// Module Name: Rippleadder
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


module rippleadder(input [3:0]a,input [3:0] b,input cin,output[3:0] o,output cout);
wire c1,c2,c3;
FA f0(.a(a[0]),.b(b[0]),.cin(cin),.s(o[0]),.cout(c1));
FA f1(.a(a[1]),.b(b[1]),.cin(c1),.s(o[1]),.cout(c2));
FA f2(.a(a[2]),.b(b[2]),.cin(c2),.s(o[2]),.cout(c3));
FA f3(.a(a[3]),.b(b[3]),.cin(c3),.s(o[3]),.cout(cout));

endmodule
