module priority_encoder_tb();
reg I0,I1,I2,I3,I4,I5,I6,I7;
wire  Y0,Y1,Y2;
priority_encoder DUT(I0,I1,I2,I3,I4,I5,I6,I7, Y0, Y1, Y2);
initial
begin
I7=1'b0;
I6=1'b1;
I5=1'b0;
I4=1'b0;
I3=1'b1;
I2=1'b0;
I1=1'b1;
I0=1'b0;
end

initial
$monitor("Input I7=%b,I6=%b,I5=%b,I4=%b,I3=%b,I2=%b,I1=%b,I0=%b, Output Y2=%b,Y1=%b,Y0=%b", I7,I6,I5,I4,I3,I2,I1,I0, Y2, Y1, Y0);
initial
#100 $finish;
endmodule