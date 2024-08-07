module fun_vid();
int z,q;
/*function int display(a,b);
display=a+b;
endfunction

initial
begin
z=display(5,10);
$display("Reult =%d",z);
end
*/
function void display(a,b,c);
//display=2*a;
c=a+b;
endfunction
initial
begin
q=display(5,10,z);
$display("Reult =%d",z);
end

endmodule
