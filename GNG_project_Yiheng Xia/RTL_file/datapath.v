module datapath(clk,rst,en,dataa,segment,result,done);
input  clk,rst,en;
input [14:0] dataa;
input [6:0] segment;
output[15:0] result;
output  done;

rom U0(
   .address   (segment),
   .read_en   (read_en),
   .Coef2     (Coef2),
   .Coef1     (Coef1),
   .Coef0     (Coef0)
);

mult1 U1(
   .dataa   (dataa),
   .datab   (Coef2),
   .product (product_m1)
);

adder1 U2(
   .dataa   (product_m1),
   .datab   (Coef1),
   .sum     (sum_a1)
);

mult2 U3(
   .dataa   (dataa),
   .datab   (sum_a1),
   .product (product_m2)
);

adder2 U4(
   .a       (product_m2),
   .b       (Coef0),
   .sum     (sum_a2)
);

wire [6:0] segment;
wire [14:0] dataa;
reg  [15:0] result;
reg done;
//wire   read_en;
//wire [17:0] Coef2;
//wire [17:0] Coef1;
//wire [20:0] Coef0;
//wire [17:0] product_m1;
//wire [17:0] sum_a1;
//wire [19:0] product_m2;
//wire [15:0] sum_a2;
reg  enable;
assign read_en=enable;
always @(posedge clk)
begin
   if(rst==1)begin
     result=0;
     done =0;
   end
   else if (en==1)begin
     enable =1;
     result = sum_a2;
     done =1;   
   end
end
endmodule