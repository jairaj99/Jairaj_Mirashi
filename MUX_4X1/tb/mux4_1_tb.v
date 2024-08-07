module mux4_1_tb();

   //Step1 : Write down the variables required for testbench
reg [3 : 0] data_in;
reg [1:0] sel_in;
wire y_out;		
								
   //Step2 : Instantiate the Design 
mux4_1 DUT(data_in, sel_in, y_out);

   //Step3 : Declare a task to initialize inputs of DUT to 0
task initilize;
begin
{data_in, sel_in}=0;
end
endtask

   //Step4 : Declare  tasks with arguments for driving stimulus to DUT 
task stimulus(input [3:0]i, input[1:0]j);
begin
#10;
data_in = i;
sel_in = j;
end
endtask

   //Step5 : Call the tasks from procedural process 
initial
begin
initilize;
stimulus(4'd5, 2'd2);
stimulus(4'd15, 2'd3);
stimulus(4'd6, 2'd1);
end


   //Step6 : Use $monitor task to display inputs and outputs
initial
$monitor("Input Data_in =%b, Sel_in=%b, y_out= %b", data_in, sel_in, y_out);

   //Step7 : Use $finish task to terminate the simulation at 100ns
initial
#100 $stop;

   
endmodule

