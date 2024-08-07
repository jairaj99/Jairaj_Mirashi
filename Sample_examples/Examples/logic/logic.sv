module logic_test(output y);

logic a,b;
//assign a='b0;
assign b='b1;
assign y='b1;

initial
begin
a='b0;
$display(b);
end
endmodule : logic_test

module top;
logic c;
logic_test LT(c);
initial
begin
$display(c);
end
endmodule : top
