`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2025 06:17:42 PM
// Design Name: 
// Module Name: mux13x1tb
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


module tb_mux13x1;
    reg [12:0] i;
    reg [3:0] s;
    wire o;

    mux13x1 uut(.i(i), .s(s), .o(o));

    initial begin
        $display("13:1 MUX Test");
        i = 13'b1010011101110;
        for (integer k = 0; k < 16; k = k + 1) begin
            s = k[3:0]; #5;
            $display("s=%b -> o=%b", s, o);
        end
        $finish;
    end
endmodule
