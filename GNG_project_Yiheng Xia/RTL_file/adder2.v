module adder2(a,b,sum);   //trunck the LSBs for output 
input [19:0] a;
input [20:0] b;
output[15:0] sum;

wire [17:0] dataa;
wire [20:0] datab;
reg  [21:0] temp;
reg  [15:0] sum;

always @(dataa,datab)begin
    temp =dataa +datab;
    sum = temp[21:6];
end
endmodule