`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2020 10:00:59 AM
// Design Name: 
// Module Name: alu
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


module alu(
    input   logic [31:0]    a,b,
    input   logic [2:0]     alucont,
    output  logic [31:0]    result,
    output  logic           zero
);

    logic [31:0] bb;
    logic [32:0] s;

    always_comb
    begin
        bb = alucont[2]?~b:b;//mux F2;
        s = {1'b0,a} + {1'b0,bb} + {32'b0,alucont[2]};//adder;
        case(alucont[1:0])//mux F0:1
            3'b00:     result = a & bb;             //result = a and b/~b
            3'b01:     result = a | bb;             //result = a or b/~b
            3'b10:     result = s[31:0];         //result = a + - b
            3'b11:     result = {31'b0,s[31]};   //result = (a < b); (zero extended)
        endcase
        zero = (result == 0);
    end
endmodule
