`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2025 06:09:11 PM
// Design Name: 
// Module Name: mux2x1tb
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


module tb_mux2x1();
    reg a, b, s;
    wire o;

    mux2x1 uut(.a(a), .b(b), .s(s), .o(o));

    initial begin
        $display("2:1 MUX Test");
        $monitor("s=%b -> o=%b", s, o);
        a = 0; b = 1; s = 0; #10;
        s = 1; #10;
        $finish;
    end
endmodule
