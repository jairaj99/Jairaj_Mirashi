module arry;
/*logic [31:0] msrc[5], mdst[5];
initial
begin
for(int i=0; i<$size(msrc); i++)
msrc[i]=i;
foreach(mdst[j])
mdst[j]=msrc[j] * 4;
end
*/
int mda[3][3]='{'{0,1,2},
		'{3,4,5},
		 '{6,7,8}};
initial
begin
foreach(mda[i,j])
$display("mda[%0d][%0d] = %0d",i,j,mda[i][j]);
end
endmodule
