module decoder3to8_tb();

reg [2:0] data_in;
wire [7:0] y_out;

decoder3to8 DUT (data_in, y_out);

task initilize;
begin
{data_in}=0;
end
endtask

task stimulus(input[2:0] i);
begin
#10;
data_in=i;
end
endtask

initial
begin
initilize;
stimulus (3'd1);
stimulus (3'd2);
stimulus (3'd3);
stimulus (3'd4);
stimulus (3'd5);
stimulus (3'd6);
stimulus (3'd7);

end

initial
$monitor("Input data_in=%b, Output y_out=%b", data_in,y_out);

initial
#100 $stop;

endmodule
