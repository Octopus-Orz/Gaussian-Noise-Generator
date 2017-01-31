`timescale 1ns/1ps
module MUX_tb();
reg   clk;
reg   rst;
reg [15:0] product;
reg   sign;
wire [15:0] result;

MUX U0(
    .clk    (clk),
    .rst    (rst),
    .product(product),
    .sign   (sign),
    .result (result)
);

initial begin
 clk=0;
end
always begin
 #5 clk=~clk;
end
initial begin
  rst=1;
  #10
  rst=0;
  #10
  sign<=0;
  product<=16'b1010111100001100;
  #30
  sign<=1;
  #20
  $stop;
end
endmodule