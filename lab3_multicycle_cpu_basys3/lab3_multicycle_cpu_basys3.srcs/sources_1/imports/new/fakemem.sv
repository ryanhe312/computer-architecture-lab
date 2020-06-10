`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2020 09:19:27 AM
// Design Name: 
// Module Name: fakemem
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


module fakeimem(
    input logic [31:0] adr,
    input logic [15:0] a,b,
    output logic [31:0] rd
);
    
    logic [31:0] RAM [4:0];
    
    
    assign    RAM[0] = {16'b001000_00000_00001,a};//addi $1,$0,a
    assign    RAM[1] = {16'b001000_00000_00010,b};//addi $2,$0,b
    assign    RAM[2] = 32'b000000_00001_00010_00011_00000_100000;//add $3,$1,$2
    assign    RAM[3] = 32'b101011_00000_00011_00000_00000_000000;//sw $3,0,($0)
    assign    RAM[4] = 32'b000010_00000_00000_00000_00000_000000;//j start
    
    assign rd = RAM[adr[4:2]];
    
endmodule

module fakedmem(
    input logic clk,we,
    input logic [31:0] a,wd,
    output logic [31:0] result
);
    
    logic [31:0] RAM [1:0];
    
    always_ff@(posedge clk)
        if(we) RAM[a[2]] <= wd;
        
    assign result = RAM[0];//plus result

endmodule
