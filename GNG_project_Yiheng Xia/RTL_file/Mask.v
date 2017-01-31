module Mask(clk,rst,en,Maskin,position,Maskout,done);
input clk,rst,en;
input [14:0] Maskin;
input [6:0]  position;
output[14:0] Maskout;
output  done;

reg [14:0] tempin1;
reg [14:0] tempin2;
reg [14:0] Maskout;
reg done<=0;
integer overlap=0,i=0;
always @(posedge clk)
begin
   if(rst==1)begin
     Maskout<=15'b0;end
   else if(en==1)begin
   tempin1=Maskin;
   if(position>=47)begin
     overlap=position-46;
   end
   for(i=0;i<overlap;i=i+1)begin
     tempin1[14-i]=0;
   end
   tempin2=tempin1;
   for(i=0;i<15;i=i+1)begin
     tempin1[i]=tempin2[14-i];
   end
   Maskout=tempin1;
   done=1;
   end
end
endmodule