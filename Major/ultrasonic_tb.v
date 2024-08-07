module ultrasonic_tb (i,buzzer,led,motor,level);
reg [1:0] i;
wire [1:0] buzzer,led,motor,level;

integer j;
ultrasonic DUT(.i(i), .buzzer(buzzer), .led(led), .motor(motor), .level(level));

initial
begin
j=2'b00;
end

initial
begin
for(j=0; j<4; j=j+1);
begin
i=j;
#10;
end
end

initial
$monitor("Input I=%b, Output i=%b, buzzer=%b, led=%b, motor=%b, level=%b",i,buzzer,led,motor,level);

initial
#100 $finish;
endmodule