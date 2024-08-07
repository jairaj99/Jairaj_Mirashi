module router_top_tb();

reg clk, resetn, packet_valid;
reg [2:0] read_enb;
reg [7:0]datain;
wire err, busy;
wire [2:0] vld_out;
wire [7:0]data_out_0, data_out_1, data_out_2;

event e1,e2;

integer i;

router_top DUT(clk,resetn,packet_valid,read_enb, datain,vld_out,err,busy,data_out_0,data_out_1, data_out_2);

always
  begin
  #5;
  clk=1'b1;
  #5;
  clk=~clk;
  end
task initialize();
    begin
    {read_enb, packet_valid, datain}=0;
    end  
  endtask
  
task rst;
    begin
    @(negedge clk)
      resetn=1'b0;
    @(negedge clk)
      resetn=1'b1;
      end
  endtask
  
  
  
//packet with payload 14 FIFO_0

task t1;

reg [7:0]header, payload_data, parity;
reg [5:0]payloadlen;
reg [1:0]addr;
begin
@(negedge clk);
wait(~busy)
@(negedge clk);
payloadlen=6'd14;
addr=2'b01;
packet_valid=1'b1;
parity=0;
header={payloadlen,addr};
datain=header;
parity=parity^datain;
@(negedge clk);
wait(~busy)
  for(i=0;i<payloadlen;i=i+1)
  begin
    @(negedge clk);
    wait(~busy)
    payload_data={$random}%256;
    datain=payload_data;
    parity=parity^payload_data;        
  end      
@(negedge clk);  
wait(~busy)
packet_valid=0;        
datain=parity;
end
endtask

//packet with payload 8
task t2;
reg [7:0]header, payload_data, parity;
reg [6:0]payloadlen;
reg [1:0]addr;
begin
@(negedge clk);
wait(!busy)
@(negedge clk);
payloadlen=6'd08;
addr=2'b01;
packet_valid=1'b1;
parity=0;
header={payloadlen,addr};
datain=header;
parity=parity^datain;
@(negedge clk);
wait(~busy)
for(i=0;i<payloadlen;i=i+1)
begin
@(negedge clk);
wait(~busy)
payload_data={$random}%256;
datain=payload_data;
parity=parity^payload_data;        
end      
@(negedge clk);
wait(~busy)
packet_valid=0;        
datain=parity;
read_enb[1]=1;
end
endtask

//packet with payload 16
task t3;
reg [7:0]header, payload_data, parity;
reg [6:0]payloadlen;
reg [1:0]addr;
begin
@(negedge clk);
wait(!busy)
@(negedge clk);
payloadlen=6'd15;
addr=2'b01;
packet_valid=1'b1;
parity=0;
header={payloadlen,addr};
datain=header;
parity=parity^datain;
@(negedge clk);
wait(~busy)
for(i=0;i<payloadlen;i=i+1)
begin
if(i==14)
->e2;
@(negedge clk);
wait(~busy)
payload_data={$random}%256;
datain=payload_data;
parity=parity^payload_data;        
end      
@(negedge clk);
wait(~busy)
packet_valid=0;        
datain=parity;
end
endtask

//packet with payload 17
task t4;
reg [7:0]header, payload_data, parity;
reg [6:0]payloadlen;
reg [1:0]addr;
begin
@(negedge clk);
wait(!busy)
@(negedge clk);
payloadlen=6'd17;
addr=2'b01;
packet_valid=1'b1;
parity=0;
header={payloadlen,addr};
datain=header;
parity=parity^datain;
@(negedge clk);
wait(~busy)
for(i=0;i<payloadlen;i=i+1)
begin
if(i==15)
->e1;
@(negedge clk);
wait(~busy)
payload_data={$random}%256;
datain=payload_data;
parity=parity^payload_data;        
end      
@(negedge clk);
wait(~busy)
packet_valid=0;        
datain=parity;
end
endtask

//packet with payload 17
task t5;
reg [7:0]header, payload_data, parity;
reg [6:0]payloadlen;
reg [1:0]addr;
begin
@(negedge clk);
wait(!busy)
@(negedge clk);
payloadlen=6'd17;
addr=2'b01;
packet_valid=1'b1;
parity=0;
header={payloadlen,addr};
datain=header;
parity=parity^datain;
@(negedge clk);
wait(~busy)
for(i=0;i<payloadlen;i=i+1)
begin
@(negedge clk);
wait(~busy)
payload_data={$random}%256;
datain=payload_data;
parity=parity^payload_data;        
end      
@(negedge clk);
wait(~busy)
packet_valid=0;        
datain=parity;
end
endtask



initial
  begin
  initialize;
  rst;
  t1;
  repeat(2)
  @(negedge clk);
  read_enb[1]=1;
  wait(~vld_out[1])
  @(negedge clk);
  read_enb[1]=0;

  rst;
  
  t2;
  repeat(2)
  @(negedge clk);
  read_enb[1]=1;
  wait(~vld_out[1])
  @(negedge clk);
  read_enb[1]=0;
  rst;
  
  t3;
  
 #100;
  
  t4;
  
  #100;
  
  t2;
  repeat(2)
  @(negedge clk);
  read_enb[1]=1;
  wait(~vld_out[1])
  @(negedge clk);
  read_enb[1]=0;
  rst;
 

 @(negedge clk);
  packet_valid=1;
datain={6'd2,2'd1};
@(negedge clk);
 rst;
 @(negedge clk);
 packet_valid =0;
 
 @(negedge clk);
  packet_valid=1;
datain={6'd2,2'd1};
for(i=0;i<=2;i=i+1)
begin
@(negedge clk);
datain=i;
end
@(negedge clk);
packet_valid=0;
rst;

t2;
@(negedge clk);
@(negedge clk);
@(negedge clk);
@(negedge clk);
 packet_valid=1;
datain={6'd2,2'd1};
rst;
read_enb[1]=0;
packet_valid=0;

t5;
#50;
  
 
  end
  
  initial 
  begin
  @(e1);
  @(negedge clk);
  @(negedge clk);
   read_enb[1]=1;
   wait(~vld_out[1])
  @(negedge clk);
  read_enb[1]=0;
  rst;
  
  
  end
  
  initial 
  begin
  @(e2);
  @(negedge clk);
  @(negedge clk);
   read_enb[1]=1;
   wait(~vld_out[1])
  @(negedge clk);
  read_enb[1]=0;
  
  
  $finish;
  end
  endmodule