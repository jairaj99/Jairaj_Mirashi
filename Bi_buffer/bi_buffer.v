module bi_buffer(a,b,ctrl);

inout a;
input ctrl;
inout  b;
assign b=(&ctrl)? a:1'bz;
assign a = (&ctrl) ? 1'bz : b;

endmodule