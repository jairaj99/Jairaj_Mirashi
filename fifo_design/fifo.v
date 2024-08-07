module fifo( clk,rst,in,out ,wr_en,rd_en,empty,full); 
input clk,rst,wr_en,rd_en; 
reg [3:0] wr_ptr,rd_ptr; 
input [7:0] in; 
output reg [7:0] out; 
integer i=0; 
output empty,full; 
 
 
reg [4:0] count; 
reg [7:0] mem [15:0]; 
assign empty = (count==0)? 1'b1:1'b0; 
assign full  = (count==16)? 1'b1:1'b0; 
 
 
// pointer reset  
 
 
 
 
// read operation with its own reset operation 
always @(posedge clk) 
            begin  
        if(rst) 
        begin 
        wr_ptr <= 0; 
     for (i=0;i<16;i=i+1) 
          begin 
       mem[i] <=0; 
       end 
     end 
    else  
                    begin     
           if (wr_en && !full) 
         begin 
      wr_ptr <= wr_ptr+1; 
      mem[wr_ptr] <= in; 
      end 
        // if(wr_en && rd_en) 
        // begin 
        // mem[rd_ptr] <= in; 
      //wr_ptr <= wr_ptr +1; 
      //end 
     else ; 
           end 
   end 
always @(posedge clk) 
            begin  
         if(rst) 
      begin  
      rd_ptr<=0; 
      out<=0; 
      end 
      else  
            begin 
                     if(rd_en && !empty) 
                     begin 
                  out <= mem[rd_ptr]; 
         rd_ptr <= rd_ptr+1; 
                  end 
                        //else if (rd_en && wr_en) 
                    // begin 
                  //out <= mem[rd_ptr]; 
         //rd_ptr <= rd_ptr+1; 
                 // end 
                     else; 
      end 
      
   end  
    
always@(posedge clk) 
begin 
          if (rst)  count =0; 
          else  
               begin  
                  case({wr_en,rd_en}) 
                  2'b00 : count <= count ; 
                  2'b01 : count <= (count==0)?0:count-1; 
      2'b10 : count <= (count==16)?16:count+1; 
      2'b11 : count <= count; 
      default : count <=count ; 
      endcase 
      end 
end 
endmodule