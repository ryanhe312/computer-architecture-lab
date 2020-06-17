`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2020 11:13:56 AM
// Design Name: 
// Module Name: alu_top
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


module board_top(
	input   logic       clk,
    input   logic       btnC, btnL, btnR,
    input   logic [15:0]sw,
    
    output  logic [7:0] an,
    output  logic       dp,
    output  logic [6:0] seg
);

    logic memwrite;
    logic [31:0] writedata, dataadr, readdata;
    
    mips mips(.clk(clk), .reset(btnC), .readdata(readdata), 
                .memwrite(memwrite), .writedata(writedata), .dataadr(dataadr));
    memorydecoder md(.clk(clk), .writeEN(memwrite), .addr(dataadr), 
                        .writeData(writedata), .readData(readdata), .IOclock(~clk),
                        .reset(btnC), .btnL(btnL), .btnR(btnR), .switch(sw), .AN(an), .DP(dp), .A2G(seg));
endmodule
