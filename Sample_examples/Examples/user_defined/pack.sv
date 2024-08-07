package pkg;
int no_of_trans;

function void display(string s);
$display($time, "%s, n= %0d",s,no_of_trans);
endfunction
endpackage

module A;
import pkg::*;
initial
begin
#2;
no_of_trans=10;
#2;
display("From Module A");
end
endmodule

module B;
import pkg::*;

initial
begin
#4;
no_of_trans=20;
display("From Module B");
end
endmodule
