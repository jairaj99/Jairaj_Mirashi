module sync_tb;
 reg clock,resetn,detect_add,write_enb_reg;
 reg [2:0]full,empty,read_enb;
 reg [1:0]din;
 wire [2:0]vld_out,soft_reset,write_enb;
 wire fifo_full;
 //wire [4:0]count1,count2,count3;
sync DUT(clock,resetn,detect_add,write_enb_reg,full,empty,read_enb,din,vld_out,soft_reset,write_enb,fifo_full);
 
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
   clock=0;
  forever #5 clock=~clock;
  end
 task ful; 
 begin  
 full[0]=1'b1; 
 full[1]=1'b1; 
 full[2]=1'b1; 
 end  
 endtask   
 initial
  begin
   {clock,resetn,detect_add,write_enb_reg,full,empty,read_enb,din}=0;//12'b000000011100000
  @(negedge clock)
   resetn=0;
  @(negedge clock)
   resetn=1;

 
       detect_add = 1'b1; 
    ful; 
    write_enb_reg =1; 
    din =1'b00; 
    read_enb[0] =1'b1; 
    read_enb[1] =1'b0; 
    read_enb[2] =1'b0; 
    empty[0]    =1'b1; 
    empty[1]    =1'b0; 
    empty[2]    =1'b0; 
     
    #100; 
    din =1'b01; 
    read_enb[0] =1'b0; 
    read_enb[1] =1'b1; 
    read_enb[2] =1'b0; 
    empty[0]    =1'b0; 
    empty[1]    =1'b1; 
    empty[2]    =1'b0; 
    #100 
    din = 1'b10; 
     
    read_enb[0] =1'b1; 
    read_enb[1] =1'b0; 
    read_enb[2] =1'b0; 
    empty[0]    =1'b1; 
    empty[1]    =1'b0; 
    empty[2]    =1'b0; 


   #1000 $stop;
  end
  
endmodule
