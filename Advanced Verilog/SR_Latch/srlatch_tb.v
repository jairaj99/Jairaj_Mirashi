module srlatch_tb(); 
reg control,s,r,reset; 
wire q; 
 
 
srlatch dut(control , s ,r , q,reset); 
 
parameter thold = 5, 
          tsetup = 5, 
    cycle  = 100; 
     
initial  
          begin  
     reset = 1 ; 
     #thold; 
     if(q !== 0); 
        begin  
     $display ("Reset is not working fine as hell"); 
     $stop; 
     end  
     $display ("Congrats Nigga reset is working smoothly"); 
      
     reset = 0; 
     control = 1; 
     s     = 1; 
     r     = 0; 
     #thold; 
     if( q!==1) 
       begin  
     $display( " Chutiye ho tum jo latch set nhi hopara hopara hai"); 
     $stop; 
    end 
   $display(" Badhai ho launde kam karra hai set ka button"); 
    
   s    = 0; 
   r    = 1; 
   #thold; 
   if( q!==0) 
       begin  
     $display( " Chutiye ho tum jo latch reset nhi hopara hopara hai"); 
     $stop; 
    end 
   $display(" Badhai ho launde kam karra hai reset ka button"); 
    
   s    = 0; 
   r    = 0; 
   #thold; 
    
     if ( q !== q); 
     begin  
     $display( " Chutiye ho tum jo latch hold nhi hopara hopara hai"); 
     $stop; 
     end 
   $display(" Badhai ho launde kam karra hai hold ka button"); 
    
   s    = 1; 
   r    = 1; 
   #thold ; 
   if ( q !== 1'bx); 
     begin  
     $display( " Chutiye ho tum jo latch Invalid  nhi hopara hopara hai"); 
     $stop; 
     end 
     $display(" Badhai ho launde kam karra hai Invalid ka button"); 
     #(cycle-tsetup-thold); 
  end  
endmodule