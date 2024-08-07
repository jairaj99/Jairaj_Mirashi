module reduction;

/*int cnt,sa;
int da[]={10,1,8,3,5,5};
initial
begin
cnt=da.sum with(item>7);
sa=da.sum with(item==5);
$display("da = %p",da);
$display("Sum > 7 = %p",cnt);
$display("No of 5 in array = %p",sa);
end
*/
int da[$]={10,1,7,3,4,4};
int k=4;
initial
begin

da.reverse();
$display("da = %p, LOW = %0d",da, $low(da));
$low("LOW =%p",da);
da.sort();
$display("da = %p",da);
da.rsort();
$display("da = %p",da);
da.push_front(7);
$display("da = %p",da);
k=da.pop_back();
$display("da = %p",da);

da.delete();
$display("da = %p",da);
end

endmodule
