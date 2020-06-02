`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2020 09:37:48 AM
// Design Name: 
// Module Name: mips
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


module mips(
    input logic clk,reset,
    input logic [31:0] instr,readdata,
    output logic memwrite,
    output logic [31:0] pc,aluout,writedata
);
    logic memtoreg,alusrc,regdst,regwrite,jump,pcsrc,zero;
    logic [2:0] alucontrol;
    
    controller c(.op(instr[31:26]),.funct(instr[5:0]),.zero(zero),
                .memtoreg(memtoreg),.memwrite(memwrite),.pcsrc(pcsrc),
                .alusrc(alusrc),.regdst(regdst),.regwrite(regwrite),
                .jump(jump),.alucontrol(alucontrol));

    datapath dp(.clk(clk),.reset(reset),.memtoreg(memtoreg),
                .pcsrc(pcsrc),.alusrc(alusrc),.regdst(regdst),
                .regwrite(regwrite),.jump(jump),.alucontrol(alucontrol),
                .zero(zero),.pc(pc),.instr(instr),
                .aluout(aluout),.writedata(writedata),.readdata(readdata));

endmodule
