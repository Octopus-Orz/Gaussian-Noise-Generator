`timescale 1ns/1ps

module ROM_trans_new_tb();
reg   clk;
reg   rst;
reg [6:0] LZDout;
wire[6:0] segment;

ROM_trans_new U0(
  .clk     (clk),
  .rst     (rst),
  .LZDout  (LZDout),
  .segment (segment)
);

initial begin
  clk <= 0;
end
always begin
  #5 clk=~clk;
end
  integer n=0,i=0;
  reg     temp= 1'b0;
initial begin
  rst =1;
  #20
  rst =0;
  #10
  for(i=0;i<6;i=i+1)begin
     #20
     LZDout[6:1] = n;
     LZDout[0]   = temp;
     #20
     temp=~temp;
     LZDout[0] = temp;
     n=n+1;
  end
  #20
  $stop;
end

endmodule