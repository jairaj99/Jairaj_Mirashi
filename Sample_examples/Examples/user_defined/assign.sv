module assig;
bit [1:0][1:0] arr [2:0][1:0];

initial
begin
$display("ARRAY = %p", arr);
$display(" $left %0d",$left(arr));
$display("$right %0d",$right(arr));
$display("$low %0d",$low(arr));
$display("$high %0d",$high(arr));
$display("$increment %0d ",$increment(arr));
$display("$size %0d ",$size(arr));
$display("$dimensions %0d",$dimensions(arr));
end
endmodule
