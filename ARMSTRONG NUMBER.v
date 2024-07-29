module arm;
  int rem,a,num;
  int count=100;
  
  initial
    begin
      while(count <=500)
        begin
          num=count;
          a=0;
          
          while(num)
            begin
              rem=num%10;
              a=a+(rem*rem*rem);
              num=num/10;
            end
          if(count==a)
            begin
              $display("%0d ARMSTRONG NUMBER",count);
            end
          count++;
        end
    end
endmodule
            

//https://www.edaplayground.com/x/Ydad
