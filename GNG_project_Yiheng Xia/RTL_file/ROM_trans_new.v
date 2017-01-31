module ROM_trans_new(clk,rst,en,LZDout,segment,done);
input clk,rst,en;
input [6:0] LZDout;
//input [1:0] offset;
output[6:0] segment;
output  done;

reg [6:0] segment;
reg [5:0] temp1;
reg       temp2;
reg  done <= 0;
//reg [1:0] offset;
integer i=0;

always @(posedge clk)
begin
 if(rst==1)begin
   segment=9;   // a done signal can be added too
 end
 else if(en==1)begin
   temp1=LZDout[6:1];
   temp2=LZDout[0];
   case(temp1)
      5'b00001: segment = (temp2)? 0:1;   //this part is different from matlab due to addr in ROM starts from 0
      5'b00010: segment = (temp2)? 2:3;
      5'b00011: segment = (temp2)? 4:5;
      5'b00100: segment = (temp2)? 6:7;
      5'b00101: segment = (temp2)? 8:9;
      default: segment = 9;
    endcase
    done <= 1;
  end
end
endmodule