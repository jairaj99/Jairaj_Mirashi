module pr_encoder8_3(input [7:0] data_in, output reg [2:0] y_out );

always@(data_in)
begin

if (data_in[7] == 1'b1)
y_out=3'b111;

else if(data_in[6] == 1'b1)
y_out=3'b110;

else if(data_in[5] == 1'b1)
y_out=3'b101;

else if(data_in[4] == 1'b1)
y_out=3'b100;

else if(data_in[3] == 1'b1)
y_out=3'b011;

else if(data_in[2] == 1'b1)
y_out=3'b010;

else if(data_in[1] == 1'b1)
y_out=3'b001;

else if(data_in[0] == 1'b1)
y_out=3'b000;

else
y_out= 3'bzzz;

end

endmodule