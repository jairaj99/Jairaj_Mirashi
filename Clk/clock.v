module clock(output reg clk);

parameter t=10;

initial
begin
clk= 1'b0;
forever #(t/2) clk = ~clk;
end

/*always
begin
#(t/2);
clk=1'b0;
#(t/2);
clk=1'b1;
end
*/

initial
#200 $finish;

endmodule