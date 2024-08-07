module pitfalls_op();

reg [15 : 0] a;
integer i,j;

initial
begin
i= -12/3;
j='d12/3;
a=-12/3;

$display("i=%d,j=%d, a=%d",i,j,a );
end
endmodule