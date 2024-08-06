module adder(input clk,        // Clock input
             reset,           // Reset input
             input [7:0] in1, // 8-bit input variable
             in2,             // 8-bit input variable
             output reg [8:0] out); // 9-bit output variable
  
  // Sequential logic sensitive to positive edge of clock or reset
  always @(posedge clk or posedge reset) begin 
    if(reset)
      out <= 0;    // Reset condition: set output to 0
    else
      out <= in1 + in2; // Normal operation: add inputs in1 and in2 and assign to output out
  end
endmodule


/*
//Verilog based TB
module design_tb;
  reg clk, reset;
  reg [7:0] ip1, ip2;
  wire [8:0]out;
  
  adder dut(.clk(clk), .reset(reset), .in1(ip1), .in2(ip2), .out(out));
  //adder add(.clk(clk), .reset(reset), .ip1(in1), .ip2(in2), .out(out));
  
  always #5 clk = ~clk;
    

  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    clk = 0;
    ip1= 0;
    ip2= 0;
    reset = 0;
    #2ns;
    reset = 1;
    
    #2ns;
    reset = 0;
    #10;
    
    ip1= 5;
    ip2= 2;
    #5;
    $display("End.");
    $finish;
  end 

endmodule
*/