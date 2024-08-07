module ripple_adder_tb();

reg [3:0] x,y;
reg Cin;
wire [3:0] S;
wire C;

integer i;

ripple_adder DUT(x,y,Cin,S,C);

initial
begin
x=4'b0000;
y=4'b0000;
Cin=0;
end

initial
begin
for(i=0; i<16; i=i+1)
begin
x=i;
y=i;
#10;
end
end

initial
$monitor("Input X=%b, Y=%b, Cin=%b  Output Sum=%b, Carry=%b", x,y,Cin,S,C);

initial
#100 $finish;

endmodule