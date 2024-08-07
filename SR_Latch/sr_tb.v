module sr_tb();

reg s,r;
wire q;
wire qb;

sr dut(s,r,q,qb);


task delay;
begin
#10;
end
endtask

task initilize;
begin
{s,r} = 0;
end
endtask


task sr_input(input l,m);
begin
s=l;
r=m;
end
endtask

initial
begin
initilize;
sr_input(1'b0, 1'b1);
delay;
sr_input(1'b0, 1'b0);
delay;
sr_input(1'b1, 1'b0);
delay;
sr_input(1'b1, 1'b1);

end


initial
$monitor("Input S= %b, R = %b, Output Q = %b, Qb = %b", s, r, q,qb);

initial
#100 $stop;

endmodule