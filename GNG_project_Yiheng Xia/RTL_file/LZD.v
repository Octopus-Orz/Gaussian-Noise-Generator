module LZD(clk,rst,en,LZDin,LZDout,position,done);
input clk,rst,en;
input [60:0] LZDin;
output [6:0] LZDout;
output [5:0] position;
output  done;

reg [5:0] position="000000";
reg [6:0] LZDout="0000000";
reg [60:0] temp;
reg [5:0] n="000000";
reg  done <=0;
integer j=0;
always @(posedge clk)
begin
if(rst==1)begin
LZDout<=0;
position<=0;
n=0;
j=0;
end
else if(en==1)begin
temp=LZDin;
   while(temp[60-j]==1)  //when there's 0 detected, break it
     begin
       n=n+1;
       j=j+1;
     end
position = n+1;
LZDout={position,LZDin[59-j]};
done = 1;
end
end
endmodule