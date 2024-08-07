module ultrasonic(i,buzzer,led,motor,level);
input [1:0] i;
output reg [1:0] buzzer,led,motor,level;

always @(*)
begin
if (i==0)
begin
level=i;
led=0;
buzzer=0;
motor=1;
end
else if(i==1)
begin
level=i;
led=1;
buzzer=0;
motor=1;
end
else if(i==2)
begin
level=i;
led=0;
buzzer=1;
motor=1;
end
else if(i==3)
begin
level=i;
led=0;
buzzer=0;
motor=0;
end
end
endmodule
