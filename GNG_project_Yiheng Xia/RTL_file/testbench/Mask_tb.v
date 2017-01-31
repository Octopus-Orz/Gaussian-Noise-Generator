`timescale 1ns/1ps

module Mask_tb();
reg clk;
reg rst;
reg [14:0] Maskin;
reg [6:0]  position;
wire[14:0] Maskout;

Mask U0(
    .clk     (clk),
    .rst     (rst),
    .Maskin  (Maskin),
    .position(position),
    .Maskout (Maskout)
);
initial begin
  clk<=0;
end
initial begin
  rst<=1;
#10
  rst<=0;
#10
  Maskin<=15'b111101111011110;
  position<=7'b0011000;
#40
  Maskin<=15'b100101001011110;
  position<=7'b0111000;
#40
  Maskin<=15'b111111111011110;
  position<=7'b0101111;  
#40
$stop;
end
always begin
#5 clk=~clk;
end
endmodule
