interface add_if(
  input logic clk,      // Clock input
  input logic reset    // Reset input
);
  logic [7:0] ip1;     // 8-bit input variable 1
  logic [7:0] ip2;     // 8-bit input variable 2
  logic [8:0] out;     // 9-bit output variable
endinterface
