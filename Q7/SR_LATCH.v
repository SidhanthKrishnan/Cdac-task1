`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2025 03:48:58 PM
// Design Name: 
// Module Name: SR_LATCH
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


module SR_LATCH(input s,input r,input e,output reg q,output q_bar);
assign q_bar=!q;
always@(*)begin

if(e && (s|r))begin
    if(s && r) q=1'bx;
    else q=s;
end

end
endmodule
