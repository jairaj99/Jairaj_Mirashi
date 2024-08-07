module quee;
/*
int qm1[$]={1,3,4,5,6};
int qm2[$]={2,3};
int k=2;
initial
begin
qm1.insert(1,k);
qm1.delete(1);
qm1.push_front(7);
k=qm1.pop_back();
qm2.push_back(4);
k=qm2.pop_front();
qm2.pop_front();
foreach(qm1[i])
$display(qm1[i]);
//qm2.delete();
$display("qm2= %p",qm2);
end
*/
//Example 2
int k;
int q[$]='{1,2,3,4,5,6};
initial
begin
for(int i=0; i<5; i++)
begin
k=q.pop_back();
$display("%p",q);
end
//$display("%p",q);
end
endmodule
