`timescale 1ns/1ps
module mult1_tb();
reg [14:0]  dataa;
reg [17:0]  datab;
wire[17:0]  product;

mult1 U0(
    .dataa  (dataa),
    .datab  (datab),
    .product (product)
);

initial begin
#10
  dataa= 15'b000000000000001;
  datab= 18'b000000000000000011;
#50
  dataa= 15'b000000000000100;
  datab= 18'b000111111111111000;
#50
  dataa= 15'b001111111111111;
  datab= 18'b111110000000000000;
end
endmodule
