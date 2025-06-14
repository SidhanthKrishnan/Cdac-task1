`timescale 1ns / 1ps
module tb_T_ff();
  reg t, clk, pr, cr;
  wire q, q_bar;
  T_ff uut(.t(t), .clk(clk), .pr(pr), .cr(cr), .q(q), .q_bar(q_bar));
  initial begin
    clk=0;
    t=0;
    pr=0; cr=1; #2;
    pr=0; cr=0; #2;
    t=1;
    #5;
    t=0;
    #5;
    t=1;
    #5;
    $finish;
  end

 
  always #5 clk = ~clk;
endmodule
