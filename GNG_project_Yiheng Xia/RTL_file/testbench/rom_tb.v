`timescale 1ns/1ps
module rom_tb();
 reg [6:0] address;
 reg read_en;
 wire [17:0] Coef2;
 wire [17:0] Coef1;
 wire [20:0] Coef0;
 integer i;
 
 initial begin
   address = 0;
   read_en = 0;
   #10 $monitor ("address = %h, Coef2 = %b, Coef1= %b, Coef0 =%b, read_en = %b", address,Coef2,Coef1, Coef0, read_en);
   for (i = 0; i <10; i = i +1 )begin
     #5 address = i;
     read_en = 1;
     #5 read_en = 0;
     address = 0;
   end
 end
 
rom U0(
  .address (address), 
  .read_en (read_en),
  .Coef2    (Coef2),
  .Coef1    (Coef1),
  .Coef0    (Coef0)    
);
endmodule