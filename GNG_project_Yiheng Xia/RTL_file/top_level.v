module top_level(clk,rst,random,go,awgn_out,done);
input   clk;
input   rst;
input [63:0]random;    
input   go;
output[15:0]awgn_out;
output done;

wire clk,rst,go;
wire  [63:0]random;
reg   awgn_out;
reg   done;
reg LZD_done,Mask_done, ROM_trans_done,datapath_done,MUX_done;
wire LZD_done_w,Mask_done_w, ROM_trans_done_w,datapath_done_w,MUX_done_w;
wire [6:0]  LZDout_w,segment_w;
wire LZD_en_w,Mask_en_w,ROM_trans_en_w,datapath_en_w,MUX_en_w;
wire LZD_en,Mask_en,ROM_trans_en,datapath_en,MUX_en;
assign LZD_done_w <= LZD_done;
assign Mask_done_w <= Mask_done;
assign ROM_trans_done_w <= ROM_trans_done;
assign datapath_done_w <= datapath_done;
assign MUX_done_w <= MUX_done;
assign LZD_en_w <= LZD_en;
assign Mask_en_w <= Mask_en;
assign ROM_trans_en_w <= ROM_trans_en;
assign datapath_en_w <= datapath_en;
assign MUX_en_w <= MUX_en;

LZD  U0 (
    .clk    (clk),
    .rst    (rst),
    .en     (LZD_en_w),
    .LZDin  (random[63:3]),
    .LZDout (LZDout_w),
    .position(position),
    .done   (LZD_done_w)
);

Mask U1(
    .clk    (clk),
    .rst    (rst),
    .en     (Mask_en_w),   
    .Maskin (random[17:3]),
    .position(position),
    .Maskout(Maskout),
    .done   (Mask_done_w) 
);

ROM_trans_new U2(
    .clk    (clk),
    .rst    (rst),
    .en     (ROM_trans_en_w),    
    .LZDout (LZDout_w),
    .segment(segment_w),
    .done   (ROM_trans_done_w)
);

datapath U3(
    .clk    (clk),
    .rst    (rst),
    .en     (datapath_en_w),    
    .dataa  (dataa),
    .segment(segment_w),
    .result (datapath_result_w),
    .done   (datapath_done_w)
);

MUX U4(
    .clk    (clk),
    .rst    (rst),
    .en     (MUX_en_w),
    .product(product),
    .sign   (random[0]),
    .result (MUX_result_w),
    .done   (MUX_done_w)
);

parameter A=3'b000, B=3'b001,C=3'b010,D=3'b011,E=3'b100,F=3'b101;
reg [2:0]  state;
reg [2:0]  next_state;

always @(state or go)begin    //6 state to make sure the data flows correctly
  next_state = 3'b000;
  case(state)
      A: if(go==1)begin
           next_state =B;
         end else begin
           next_state =A;
         end
      B: if(LZD_done==1)begin
           next_state = C;
         end else begin
           next_state = B;
         end
      C: if(Mask_done==1&& ROM_trans_done==1)begin
           next_state = D;
         end else begin
           next_state = C;
         end
      D: if(datapath_done==1)begin
           next_state = E;
         end else begin
           next_state = D;
         end
      E: if(MUX_done==1)begin
           next_state = F;
         end else begin
           next_state = E;
         end
      F: next_state = A;
      default: next_state = A;
end

always @(posedge clk)
begin
     if(rst==1)begin
       state <= A;
     end else begin
       state <= next_state;
     end
     case(state):
     A: begin awgn_out <=0;     //idle state, wait for go signal, set all enable signals 0
              LZD_en <=0;
              Mask_en<=0;
              ROM_trans_en <=0;
              datapath_en <=0;
              MUX_en <=0;
        end   //idle state,waiting for go signal

     B: begin LZD_en<=1; end        // LZD starts working
     C: begin Mask_en <=1;          //Mask gets the position from LZD, starts working
              ROM_trans_en <=1; end //ROM_trans get postion, starts working
     D: begin datapath_en <=1; end  //datapath calculates result
     E: begin MUX_en<=1 ; end 
     F: begin awgn_out <= MUX_result_w;//
              done <= 1;
        end
end

endmodule