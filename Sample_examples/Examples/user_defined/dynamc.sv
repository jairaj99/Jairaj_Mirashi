module dynamc;
int da1[],da2[];
initial
begin
da1=new[10];
foreach(da1[i])
da1[i]=i;
da2=da1;
$display("da1=%p, \n da2=%p \n",da1,da2);
da1=new[10](da1);
//da1=new[100];
$display("da1=%p,\n da2=%p \n",da1,da2);
da2.delete();
$display("da1=%p, \n da2=%p \n",da1,da2);
end
endmodule
