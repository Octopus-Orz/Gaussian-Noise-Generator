`timescale 1ns/1ps

module datapath_tb();
reg clk;
reg rst;
reg [14:0] dataa;
reg [6:0] segment;
wire[15:0] result;
wire  done;

datapath U0(
    .clk    (clk),
    .rst    (rst),
    .dataa  (dataa),
    .segment(segment),
    .result (result),
    .done   (done)
);

initial begin
   clk = 0;
end
always begin
   clk = ~ clk;
end
initial begin
   rst=1;
   #20
   rst=0;
   #10
  dataa= 15'b100010001001001;
  segment= 6'b000001;
#50
  dataa= 15'b100010001001001;
  segment= 6'b000010;
#50
  dataa= 15'b100010001001001;
  segment= 6'b000011;
end
endmodule