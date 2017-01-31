module mult1(dataa,datab,product);  //trunck the LSBs for output
input  [14:0] dataa;
input  [17:0] datab;
output [17:0] product;

wire [14:0] dataa;
wire [17:0] datab;
reg [17:0] product;
reg [32:0] temp;
always @(dataa,datab)begin
     temp = dataa*datab;
     product = temp[32:15];
end
endmodule 