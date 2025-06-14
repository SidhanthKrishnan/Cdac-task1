`timescale 1ns / 1ps
module tb_jk_using_t();
  reg j, k, clk, pr, cr;
  wire q, q_bar;

  JK_using_T uut(.j(j), .k(k), .clk(clk), .pr(pr), .cr(cr), .q(q), .q_bar(q_bar));

  initial begin
    clk = 0;
    j = 0; k = 0;
    pr = 1; cr = 0; #2;
    cr = 1;
    j = 0; k = 1; #10;
    j = 1; k = 0; #10;
    j = 1; k = 1; #10;
    j = 0; k = 0; #10;
    $finish;
  end

  always #5 clk = ~clk;
endmodule
