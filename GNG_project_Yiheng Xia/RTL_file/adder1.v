module adder1(dataa,datab,sum);  //trunk the LSBs for output
input [17:0] dataa,datab;
output[17:0] sum;

wire [17:0] dataa,datab;
reg [18:0] temp;
reg [17:0] sum;

always @(dataa,datab)begin
    temp =dataa +datab;
    sum = temp[17:0];
end
endmodule