
module clk_gen;
reg clk;
parameter T=3.90625;
initial
begin

clk=1'b0;
forever #(T/2) clk = ~clk;
end

endmodule 