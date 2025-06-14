`timescale 1ns / 1ps
module tb_d_using_t();
  reg d, clk, pr, cr;
  wire q, q_bar;

  D_using_T uut(.d(d), .clk(clk), .pr(pr), .cr(cr), .q(q), .q_bar(q_bar));

  initial begin
    clk = 0;
    d = 0;
    pr = 1; cr = 0; #2;
    cr = 1;
    d = 1; #10;
    d = 0; #10;
    d = 1; #10;
    d = 1; #10;
    $finish;
  end

  always #5 clk = ~clk;
endmodule

