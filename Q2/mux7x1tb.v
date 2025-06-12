`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2025 06:15:32 PM
// Design Name: 
// Module Name: mux7x1tb
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


module tb_mux7x1();
    reg [6:0] i;
    reg [2:0] s;
    wire o;

    mux7x1 uut(.i(i), .s(s), .o(o));

    initial begin
        $display("7:1 MUX Test");
        i = 7'b1010101;
        for (integer j = 0; j < 8; j = j + 1) begin
            s = j[2:0]; #5;
            $display("s=%b -> o=%b", s, o);
        end
        $finish;
    end
endmodule
