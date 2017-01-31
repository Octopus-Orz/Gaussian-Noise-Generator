`timescale   1ns/1ps
module adder1_tb();
reg [17:0] dataa,datab;
wire [17:0] sum;

adder1 U0 (
    .dataa   (dataa),
    .datab   (datab),
    .sum     (sum)
);

initial begin
#10
dataa= 18'b000111000111000111;
datab= 18'b001001001001001001;
#10
dataa= 18'b111111111111000111;
datab= 18'b001001001001001001;
#10
dataa= 18'b000111000000000001;
datab= 18'b001001001001001001;
#10
dataa= 18'b000111000111000111;
datab= 18'b001001001111001001;
end
endmodule