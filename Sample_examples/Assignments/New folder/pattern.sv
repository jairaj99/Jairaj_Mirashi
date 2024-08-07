//021346578

class e_o;

rand int a[];
int j=0,k=0;

constraint size{a.size==9;}
constraint C1{foreach (a[i])
		a[i]==fun(i);}
function int fun(int i);
if(i%2==0)
begin
if(j==1)
begin
fun=i-1;
j=0;
end
else
begin
fun=i;
j++;
end
end
else
begin
if(k==0)
begin
fun=i+1;
k=1;
end
else
begin
fun=i;
k=0;
end
end
endfunction
endclass

e_o e=new();
module tb;
initial
begin
assert(e.randomize());
$display(e.a);
end
endmodule
