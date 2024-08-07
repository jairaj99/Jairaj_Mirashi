module mux4_1_tb();

reg [1:0] S;
reg [3:0] I;
wire Y;
integer i;

mux4_1 DUT(S,I,Y);

initial
begin
S=1'b0;
I=1'b0;
end

initial
begin
for(i=0; i<64; i=i+1)
begin
S=i;
I=i;
#10;
end
end

initial
$monitor("Inputs S=%b, I=%b, Output Y=%b",S,I,Y);

initial
#100 $finish;

endmodule