
class sub_class;
int obj;
endclass:sub_class

class transaction;
int data;
sub_class sub_h=new();
endclass: transaction

module test;
transaction trans_h1, trans_h2;
initial
begin
trans_h1=new;
trans_h1.data=4;
trans_h1.sub_h.obj=5;
trans_h2=new trans_h1;
$display("trans_h2 = %d", trans_h2);
end
endmodule : test
