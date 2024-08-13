module fifo(clk,rst,we,re,data_in, data_out,full, empty);

input clk,rst,we,re;
input [7:0] data_in;
output reg [7:0] data_out;
output full,empty;
reg [3:0] rd_pt, wr_pt;
reg [7:0] mem[16:0];
integer i;

always@(posedge clk)
if(rst)
beginmodule fifo(
    input clk,
    input rst,
    input we,
    input re,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output full,
    output empty
);

reg [3:0] rd_pt, wr_pt;
reg [7:0] mem[15:0]; // FIFO depth is 16, so indexing is from 0 to 15
integer i;

always @(posedge clk or posedge rst)
begin
    if (rst) begin
        data_out <= 0;
        wr_pt <= 0;
        rd_pt <= 0;
        for (i = 0; i < 16; i = i + 1)
            mem[i] <= 0;
    end
    else begin
        if (we && !full) begin
            mem[wr_pt] <= data_in;
            wr_pt <= wr_pt + 1;
        end
        if (re && !empty) begin
            data_out <= mem[rd_pt];
            rd_pt <= rd_pt + 1;
        end
    end
end

assign empty = (wr_pt == rd_pt);
assign full = (wr_pt == 15 && !re && we);

endmodule

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
 
assign empty = (rd_pt ==1) ? 1'b1 : 1'b0;
assign full = ( wr_pt==1 ) ? 1'b1 : 1'b0;

endmodule
