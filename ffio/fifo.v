module fifo(clk,rst,we,re,data_in, data_out,full, empty);

input clk,rst,we,re;
input [7:0] data_in;
output reg [7:0] data_out;
output full,empty;
reg [3:0] rd_pt, wr_pt;
reg [7:0] mem[15:0];
integer i;

always@(posedge clk)
if(rst)
begin
data_out <= 0;
wr_pt <=0;
rd_pt <=0;
for(i=0; i< 16; i=i+1)
mem[i] <=0;
end

else if(we==1 && full==0)
begin
mem[wr_pt] <= data_in;
wr_pt <= wr_pt+1;
end

else if(re==1 && empty==0)
begin
data_out <= mem[rd_pt];
rd_pt <= rd_pt+1;
end
assign empty = (rd_pt ==4'b1111) ? 1'b1 : 1'b0;
assign full = ( wr_pt ==4'b1111 && rd_pt== 4'b0000) ? 1'b1 : 1'b0;

endmodule
=============================================================================
module jFIFO(DATAOUT, full, empty, clock, reset, wn, rn, DATAIN);
  output reg [7:0] DATAOUT;
  output full, empty;
  input [7:0] DATAIN;
  input clock, reset, wn, rn; // Need to understand what is wn and rn are for
  
  reg [2:0] wptr, rptr; // pointers tracking the stack
  reg [7:0] memory [7:0]; // the stack is 8 bit wide and 8 locations in size
  
  always @(posedge clock)
  begin
    if (reset)
      begin
        for(i=0;i<=8;i=i+1)
          memory[i]<=0;
        DATAOUT <= 0; wptr <= 0; rptr <= 0;
      end
    else if (wn & !full)
      begin
        memory[wptr] <= DATAIN;
        wptr <= wptr + 1;
      end
    else if (rn & !empty)
      begin
        DATAOUT <= memory[rptr];
        rptr <= rptr + 1;
      end
  end
  
  assign full = ( (wptr == 3'b111) & (rptr == 3'b000) ? 1 : 0 );
  assign empty = (wptr == rptr) ? 1 : 0;
endmodule