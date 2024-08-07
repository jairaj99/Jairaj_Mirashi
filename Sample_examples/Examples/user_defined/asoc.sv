module asoc;
int amem[int];
initial
begin
amem[2]=1;
amem[100]=5;
amem[5]=60;
amem[200]=89;
amem[199]=89;
amem[50]=89;
if(amem.exists(5))
$display("entry exists in mem, whose value is %0d", amem[205]);
else
$display("no entry");
$display("number of entries in array is %0d",amem.num);
end
endmodule

