`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2025 03:20:26 PM
// Design Name: 
// Module Name: logic_gates_testbench
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


module logic_gates_testbench();
reg a,b;
wire o1,o2,o3,o4,o5,o6,o7;
Logic_gates_Dataflow dut(.a(a),.b(b),.o1(o1),.o2(o2),.o3(o3),.o4(o4),.o5(o5),.o6(o6),.o7(o7),.o8(o8));

initial begin
a=0; b=0;
#10;
a=0; b=1;
#10;
a=1; b=0;
#10;
a=1; b=1;
#10;
$finish;
end
endmodule
