'define MIN

module area_min(input a,b,c,d, output y );
'ifdef MIN
assign y= a & b;
'else
assign y= (a & b) | (c & d);
'endif

endmodule