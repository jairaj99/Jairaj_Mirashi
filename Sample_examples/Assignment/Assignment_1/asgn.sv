module asgn();

class AB;
rand int da[];
constraint da_val_1{da.size==10;
			foreach(da[i])
			da[i] inside{[1:100]};}
function void post_randomize();
$display("Befor sorting the content the array is %p",da);
for(int i=0; i<10; i++)
begin
for(int j=i+1; j<10; j++)
if(da[i]>da[j])
begin
da[i]=da[i]+da[j];
da[j]=da[i]-da[j];
da[i]=da[i]-da[j];
end
end
//da.sort();
$display("After sorting the content of the array is da= %p ", da);
endfunction
endclass

AB a_h=new();
initial
begin
void'(a_h.post_randomize());
end

endmodule
