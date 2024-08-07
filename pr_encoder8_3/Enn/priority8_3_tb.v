module pr_encoder8_3_tb();

reg [7:0] data_in;
wire  [2:0] y_out;

pr_encoder8_3 DUT(data_in, y_out);


task initilize;
begin
data_in=0;
end
endtask

task delay;
begin
#10;
end
endtask

task data_i(input [7:0] i);
begin
data_in=i;
end
endtask

initial
begin
initilize;
data_i(8'b00000001);
delay;
data_i(8'b00100000);
delay;
data_i(8'b01000001);
delay;
data_i(8'b00001001);
end

initial
$monitor("Input data_in=%b, Output y_out= %b", data_in, y_out);

initial
#100 $finish;

endmodule