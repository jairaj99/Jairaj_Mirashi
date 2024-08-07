module arrycc;

bit [31:0] msrc[5]={0,1,2,3,4},
	   mdst[5]={5,4,3,2,1};

initial
begin
if(msrc==mdst)
$display("msrc is equal to mdst \n  %0p = %0p",msrc,mdst);
else
$display("msrc is not equal to mdst \n %0p != %0p",msrc,mdst);

mdst=msrc;

if(msrc[1:4]== mdst[0:3])
$display("msrc is equal to mdst \n %0p = %0p", msrc[1:4],mdst[1:4]);
else
$display("msrc is not equal to mdst \n %0p != %0p",msrc[1:4],mdst[0:3]);
end

endmodule
