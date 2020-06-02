`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2020 09:40:59 AM
// Design Name: 
// Module Name: test_top
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


module test_top(
    input   logic           clk, reset, 
    output  logic [31:0]    writedata, dataadr,
    output  logic           memwrite
);
    logic [31:0] pc, instr, readdata;
    
    mips mips(.clk(clk), .reset(reset), .pc(pc), .instr(instr), .memwrite(memwrite), 
                .aluout(dataadr), .writedata(writedata), .readdata(readdata));
    imem imem(.a(pc[7:2]), .rd(instr));
    dmem dmem(.clk(clk), .we(memwrite), .a(dataadr), .wd(writedata), .rd(readdata)); 

endmodule
