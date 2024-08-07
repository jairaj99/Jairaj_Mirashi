module synchronizer_tb;
reg clock,resetn,detect_add,write_enb_reg;
reg [2:0]full,empty,read_enb;
reg [1:0]din;
wire [2:0]vld_out,soft_reset,write_enb;
wire [4:0]count1,count2,count3;
wire fifo_full;

synchronizer DUT(clock,resetn,detect_add,write_enb_reg,full,empty,read_enb,din,vld_out,soft_reset,write_enb,fifo_full);

initial
begin
clock=0;
forever #5 clock=~clock;
end

task dtct;
begin
@(negedge clock)
detect_add=1;
din=2'b10;
@(negedge clock)
detect_add=0;
end
endtask

task write;
begin
@(negedge clock)
write_enb_reg=1;//write_enb=100,000
@(negedge clock)
din=2'b10;//write_enb=001
end
endtask

initial
begin
{clock,resetn,detect_add,write_enb_reg,full,empty,read_enb,din}=0;
@(negedge clock)
resetn=0;
@(negedge clock)
resetn=1;
empty=3'b100;
dtct;
write;
//empty=1;
#100;
@(negedge clock)
full=3'b001;//full=15=1111=111,,7=111
read_enb=3'b101;//rd_en=001
#500 $stop;
end
endmodule