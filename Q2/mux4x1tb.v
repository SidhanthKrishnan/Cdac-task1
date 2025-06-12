`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2025 06:12:24 PM
// Design Name: 
// Module Name: mux4x1tb
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


module tb_mux4x1();
    reg [3:0] i;
    reg [1:0] s;
    wire o;
    mux4x1 uut(.i(i), .s(s), .o(o));
    initial begin
        i = 4'b1010;
        s = 2'b00; #5; $display("s=%b -> o=%b", s, o);
        s = 2'b01; #5; $display("s=%b -> o=%b", s, o);
        s = 2'b10; #5; $display("s=%b -> o=%b", s, o);
        s = 2'b11; #5; $display("s=%b -> o=%b", s, o);
        $finish;
    end
endmodule
