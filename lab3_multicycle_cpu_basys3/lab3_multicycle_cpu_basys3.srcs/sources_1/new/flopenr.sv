`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2020 09:17:11 AM
// Design Name: 
// Module Name: flopenr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flopenr #(parameter WIDTH = 8) (
    input   logic               clk, reset,
    input   logic               en,
    input   logic [WIDTH-1:0]   d,
    output  logic [WIDTH-1:0]   q
    );
    
    always_ff @(posedge clk, posedge reset)
    if(reset)   q <= 0;
    else if(en) q <= d;
    
endmodule
