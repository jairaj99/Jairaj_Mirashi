`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:33:19 12/25/2021 
// Design Name: 
// Module Name:    andgate 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module andgate(
    input A,
    input B,C,
    output sum, carry
    );

assign sum=A ^ B ^ C;
assign carry= (A & B) | (C &(A ^ B));
endmodule
