class trans; 
int i; 
function new(); 
i=10; 
endfunction   
endclass

class ex_transl extends trans; 
int i; 
function new(int i); 
super.new(i); 
this.i = i; 
endfunction 
endclass
 
ex_transl e_h; 

module abc(); 
initial 
begin 
e_h = new(10); 
$display("p",eh); 
end
endmodule 
