module locator;
/*
int da[6]={1,5,2,6,8,6};
int mq[$];
initial
begin
mq=da.min();
$display("mq= %p", mq);
mq=da.max();
$display("mq= %p", mq);
mq=da.unique();
$display("mq= %p", mq);
end
*/
int da[6]={1,6,2,6,8,6};
int mq[$];
initial
begin
mq=da.find_first with(item>5);
$display("mq= %p", mq);
mq=da.find_first_index with(item>5);
$display("mq= %p", mq);
mq=da.find_last with(item>5);
$display("mq= %p", mq);
mq=da.find_last_index with(item>5);
$display("mq= %p", mq);
end

endmodule
