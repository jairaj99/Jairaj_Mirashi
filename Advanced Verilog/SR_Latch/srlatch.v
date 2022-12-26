module srlatch(control , s ,r , q,reset); 
input s , r, control,reset; 
output reg q ; 
 
always@(control,s,r) 
  begin  
   if (reset) 
     q <= 0; 
  
   else  
      begin  
      if(!control) 
         begin  
         q <=q; 
      end  
   else  
      begin  
        if ({s,r} == 2'b00) 
       begin  
           q <= q; 
       end  
     else if ({s,r} == 2'b01) 
             begin 
        q <= 1'b0; 
       end  
     else if ({s,r} == 2'b10) 
              begin  
        q<= 1'b1; 
        end  
    else  
         q<= 1'bx; 
    end  
  end  
  end  
endmodule