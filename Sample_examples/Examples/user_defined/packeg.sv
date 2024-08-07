package pkg1;
int no_of_trans=10;
endpackage

package pkg2;
int no_of_trans=50;
int value;
endpackage

module mem;
import pkg1::*;
import pkg2::*;
initial
begin
$display($time,"MEM MODULE : n = %0d", pkg1::no_of_trans);
end
endmodule : mem

module cpu;
import pkg1::*;
import pkg2::*;
initial
begin
$display($time,"CPU MODULE : n = %0d", pkg2::no_of_trans);
$display($time,"CPU MODULE : Value = %0d", value);
end
endmodule :cpu
