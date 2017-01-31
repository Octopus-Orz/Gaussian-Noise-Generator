module MUX(clk,rst,en,product,sign,result,done);
input clk,rst,en;
input [15:0] product; 
input sign;
output[15:0] result;
output done;

reg [15:0] result;
reg [15:0] temp;
reg temp1;
reg  done <=0;
always @(posedge clk)begin
   if(rst==1)begin
   result<=0;
   end
   else if(en==1)begin
   temp1=sign;
   temp=product;
    if(temp1==0)begin
      result<=product;
    end
    else begin
      result<=(~product)+1'b1;
      done = 1;
    end
   end
end
endmodule