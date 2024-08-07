module disp();
reg [1:0] a;

//always@(a)
initial
begin 
for(a=0; a<10; a=a+1)
begin
$display("Hello World");
end
end
endmodule
