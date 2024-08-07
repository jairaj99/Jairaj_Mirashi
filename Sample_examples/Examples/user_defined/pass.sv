module pass;
int ma=20;
function void pass_by_value(int fa);
fa=fa*2;
$display("Inside the function Pass_by_value fa= %d", fa);
endfunction: pass_by_value

function automatic void pass_by_ref(ref int fa);
fa=fa*2;
$display("Inside the function Pass_by_ref fa= %d", fa);
endfunction: pass_by_ref

initial
begin
pass_by_value(ma);
$display("after calling the function Pass_by_value ma= %d", ma);

pass_by_ref(ma);
$display("sfter calling the function Pass_by_ref ma= %d", ma);
end

endmodule
