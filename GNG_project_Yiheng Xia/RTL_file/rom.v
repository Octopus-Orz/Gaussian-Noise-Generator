module rom (address,read_en,Coef2,Coef1,Coef0);
input  [6:0]  address;
input         read_en;
output [17:0] Coef2;
output [17:0] Coef1;
output [20:0] Coef0; 

reg [17:0]    Coef2_mem [0:9] ;
reg [17:0]    Coef1_mem [0:9] ;
reg [20:0]    Coef0_mem [0:9] ;

assign Coef2 = (read_en) ? Coef2_mem[address-1] : 18'b0;
assign Coef1 = (read_en) ? Coef1_mem[address-1] : 18'b0;
assign Coef0 = (read_en) ? Coef0_mem[address-1] : 21'b0;

initial begin
  $readmemb("Coef2.txt",Coef2_mem);
  $readmemb("Coef1.txt",Coef1_mem);
  $readmemb("Coef0.txt",Coef0_mem);
end
endmodule