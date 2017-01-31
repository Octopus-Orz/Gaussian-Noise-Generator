`timescale   1ns/1ps
module adder2_tb();
reg [17:0] dataa;
reg [20:0] datab;
wire [21:0] sum;

adder2 U0 (
    .dataa   (dataa),
    .datab   (datab),
    .sum     (sum)
);

initial begin
#10
dataa= 18'b000111000111000111;
datab= 18'b101001001001001001001;
#10
dataa= 18'b111111111111000111;
datab= 18'b110001001001001001001;
#10
dataa= 18'b000111000000000001;
datab= 18'b010001001001001001001;
#10
dataa= 18'b000111000111000111;
datab= 18'b111001001001111001001;
end
endmodule