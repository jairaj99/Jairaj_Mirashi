module bi_buffer_tb();

wire a,b;
reg ctrl;
reg tempa,tempb;

integer i;

bi_buffer DUT (a, b, ctrl);

assign a = (&ctrl) ? tempa : 1'bz ;
assign b = (&ctrl) ? 1'bz : tempb;

initial 
begin
for(i=0; i<8; i=i+1)
begin
{tempa,tempb,ctrl}=i;
#10;
end
end


initial
$monitor(" temp a=%b, temp b=%b, ctrl=%b,  a=%b, b=%b", tempa, tempb, ctrl,a,b);


initial
#100 $finish;

endmodule