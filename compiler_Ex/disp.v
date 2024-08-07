module disp();
reg [15:0] mreg;
initial
begin
mreg=101;
$display("Mreg=%h hex, %d decimal",mreg,mreg);
$display("current scope is %m");
$write("Simulation time ia %t", $time);
end

endmodule