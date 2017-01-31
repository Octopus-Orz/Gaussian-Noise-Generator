`timescale 1ns/1ps
module LZD_tb();
reg clk;
reg rst;
reg [60:0] LZDin;
wire [5:0] position;
wire [6:0] LZDout;

integer i;
LZD U0(
   .clk     (clk), 
   .rst     (rst),
   .LZDin   (LZDin),
   .LZDout  (LZDout),
   .position(position)
);
initial begin
clk <=0;
end
initial begin
rst<=1;
#10
rst<=0;
#10
LZDin[60:29]="11110111110111110111110111110100";
LZDin[28:0]=0;
//LZDin="1111111111111100101100101100101100101100101100101111111111111";
 #50
 rst<=1;
 #10
 rst<=0;
 #10
LZDin="1111101100101100101100101100101100101100101100101100101100101";
 #50
 $stop;
end
always begin
#5 clk=~clk;
end
endmodule