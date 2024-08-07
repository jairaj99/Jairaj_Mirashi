module quiz1();
reg [1:0]s;
initial
begin
$strobe("Value of strobed s =%d at time =%t",s,$time);
$display("Value of displayed s =%d at time =%t",s,$time);
s = 3;
s = 2;
#10;
$strobe("Value of strobed after delay s =%d at time =%t",s,$time);
end
endmodule
