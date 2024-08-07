class base; 
static int i; 
static function static get(); 
int a; 
a++; 
i++; 
$display(a);, 
$display(i); 
endfunction 
endclass
 
base bl_h,b2_h; 
module test(); 
initial 
begin 
bl_h.get();
bl_h.get(); 
b2_h.get(); 
end 
endmodule 

